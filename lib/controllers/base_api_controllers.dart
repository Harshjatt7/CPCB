// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/models/response/auth/login_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cpcb_tyre/models/response/error_response_model.dart';
import 'package:localization/localization.dart';
import '../constants/api_constant.dart';
import '../constants/routes_constant.dart';
import '../constants/store_key_constants.dart';
import '../models/response/base_response_model.dart';
import '../store/secure_storage.dart';
import '../utils/helper/debouncing_helper.dart';
import '../viewmodels/material_app_viewmodel.dart';

class APIBase {
  Dio? _dio;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Duration timeoutDuration = const Duration(seconds: 60);
  static final debouncer = Debouncer(milliseconds: 0);
  final MessageConstant _messageConstants = MessageConstant();

  Dio? getDio(
      {bool? isAuthorizationRequired = false,
      bool? isRefreshTokenAuthorizationRequired = false,
      bool? isMediaAuthorizationRequired = false}) {
    _dio = Dio(BaseOptions(
        baseUrl: APIRoutes.baseUrl,
        connectTimeout: timeoutDuration,
        receiveTimeout: timeoutDuration,
        responseType: isMediaAuthorizationRequired == true
            ? ResponseType.bytes
            : ResponseType.json));

    if (isAuthorizationRequired == true) {
      _dio?.interceptors.add(authorizationInterceptor);
    } else if (isRefreshTokenAuthorizationRequired == true) {
      _dio?.interceptors.add(refreshTokenAuthorizationInterceptor);
    } else if (isMediaAuthorizationRequired == true) {
      _dio?.interceptors.add(authorizationInterceptorForMedia);
    } else {
      _dio?.interceptors.add(noAuthorizationInterceptor);
    }

    return _dio;
  }

  // Interceptor for media API calls
  var authorizationInterceptorForMedia = InterceptorsWrapper(
    onRequest: (options, handler) async {
      String? token;
      await HelperFunctions().getToken();

      token = MaterialAppViewModel.token;

      options.headers["Accept"] = "application/pdf";

      options.headers['Authorization'] = "Bearer $token";

      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        // Handle refresh token here.
        APIResponse<LoginResponseModel?>? res;

        debouncer.run(() async {
          res = await MaterialAppViewModel().getRefreshToken();

          if (res?.isSuccess == false) {
            return handler.reject(error);
          } else {
            var requestOption = error.requestOptions;

            requestOption.headers['Authorization'] =
                "Bearer ${res?.data?.data?.token}";
            return handler.resolve(await Dio().fetch(error.requestOptions));
          }
        });
      } else {
        return handler.next(error);
      }
    },
  );

  // Interceptor for non authorized API calls
  var noAuthorizationInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      return handler.next(options);
    },
    onError: (error, handler) async {
      return handler.next(error);
    },
  );

  // Refresh Token Intrerceptor
  var authorizationInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      String? token;
      await HelperFunctions().getToken();

      token = MaterialAppViewModel.token;

      options.headers["Accept"] = "application/json";

      options.headers['Authorization'] = "Bearer $token";

      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        // Handle refresh token here.
        APIResponse<LoginResponseModel?>? res;

        debouncer.run(() async {
          res = await MaterialAppViewModel().getRefreshToken();

          if (res?.isSuccess == false) {
            HelperFunctions().logger("message");
            return handler.reject(error);
          } else {
            var requestOption = error.requestOptions;

            requestOption.headers['Authorization'] =
                "Bearer ${res?.data?.data?.token}";
            return handler.resolve(await Dio().fetch(error.requestOptions));
          }
        });
      } else {
        return handler.next(error);
      }
    },
  );

  // Interceptor for authorized API calls
  var refreshTokenAuthorizationInterceptor =
      InterceptorsWrapper(onRequest: (options, handler) async {
    String? refreshToken;
    await HelperFunctions().getRefreshToken();

    refreshToken = MaterialAppViewModel.refreshToken;

    options.headers["Accept"] = "application/json";

    options.headers['Authorization'] = "Bearer $refreshToken";

    return handler.next(options);
  }, onError: (error, handler) async {
    HelperFunctions().logger("message");
    await SecureStorage.instance
        .deleteSensitiveInfo(StoreKeyConstants().userType);
    await SecureStorage.instance.deleteSensitiveInfo(StoreKeyConstants().token);
    await SecureStorage.instance
        .deleteSensitiveInfo(StoreKeyConstants().refreshToken);
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().isLogin, false);

    if (APIBase.navigatorKey.currentState!.context.mounted) {
      HelperFunctions().commonErrorSnackBar(
          APIBase.navigatorKey.currentState!.context,
          MessageConstant().refreshTokenExpiredMessage);

      Navigator.pushNamedAndRemoveUntil(
          APIBase.navigatorKey.currentState!.context,
          AppRoutes.loginScreenRoute,
          (route) => false);
    }
  });

// GET $Request
  Future<APIResponse<T>?> getRequest<T>(String url,
      {bool isAuthorizationRequired = false,
      bool isRefreshTokenAuthorizationRequired = false,
      bool isMediaAuthorizationRequired = false}) async {
    Response response;
    APIResponse<T>? apiResponse;
    Dio dio = getDio(
            isAuthorizationRequired: isAuthorizationRequired,
            isMediaAuthorizationRequired: isMediaAuthorizationRequired,
            isRefreshTokenAuthorizationRequired:
                isRefreshTokenAuthorizationRequired) ??
        Dio();

    try {
      response = await dio
          .get(
            APIRoutes.baseUrl + url,
          )
          .timeout(timeoutDuration);

      apiResponse = await returnResponse<T>(response);
    } catch (err) {
      apiResponse = exceptionHandler<T>(err,
          isResponseBytes: isMediaAuthorizationRequired == true);
    } finally {}

    return apiResponse;
  }

// POST Request
  Future<APIResponse<T>?> postRequest<T>(String url,
      {dynamic data,
      bool isAuthorizationRequired = false,
      bool isRefreshTokenAuthorizationRequired = false,
      bool isMediaAuthorizationRequired = false}) async {
    APIResponse<T>? apiResponse;

    if (data == null ||
        data == "" ||
        data == '' ||
        data == " " ||
        data == ' ') {
      data = {};
    }
    Response response;
    Dio dio = getDio(
            isRefreshTokenAuthorizationRequired:
                isRefreshTokenAuthorizationRequired,
            isAuthorizationRequired: isAuthorizationRequired,
            isMediaAuthorizationRequired: isMediaAuthorizationRequired) ??
        Dio();

    try {
      response = await dio
          .post(
            APIRoutes.baseUrl + url,
            data: data,
          )
          .timeout(timeoutDuration);

      apiResponse = apiResponse ?? await returnResponse<T>(response);
    } catch (err) {
      apiResponse = exceptionHandler<T>(err);
    } finally {}

    return apiResponse;
  }

  // Patch Request
  Future<APIResponse<T>?> patchRequest<T>(String url, dynamic data,
      {bool isAuthorizationRequired = false,
      bool isRefreshTokenAuthorizationRequired = false,
      bool isMediaAuthorizationRequired = false}) async {
    if (data == null ||
        data == "" ||
        data == '' ||
        data == " " ||
        data == ' ') {
      data = {};
    }
    Response response;
    APIResponse<T>? apiResponse;
    Dio dio = getDio(
            isAuthorizationRequired: isAuthorizationRequired,
            isMediaAuthorizationRequired: isMediaAuthorizationRequired,
            isRefreshTokenAuthorizationRequired:
                isRefreshTokenAuthorizationRequired) ??
        Dio();

    try {
      response = await dio
          .patch(
            APIRoutes.baseUrl + url,
            data: data,
          )
          .timeout(timeoutDuration);
      apiResponse = await returnResponse<T>(response);
    } catch (err) {
      apiResponse = exceptionHandler<T>(
        err,
      );
    } finally {}

    return apiResponse;
  }

// PUT Request
  Future<APIResponse<T>?> putRequest<T>(String url, dynamic data,
      {bool isAuthorizationRequired = false,
      bool isRefreshTokenAuthorizationRequired = false,
      bool isMediaAuthorizationRequired = false}) async {
    if (data == null ||
        data == "" ||
        data == '' ||
        data == " " ||
        data == ' ') {
      data = {};
    }
    Response response;
    APIResponse<T>? apiResponse;
    Dio dio = getDio(
            isAuthorizationRequired: isAuthorizationRequired,
            isMediaAuthorizationRequired: isMediaAuthorizationRequired,
            isRefreshTokenAuthorizationRequired:
                isRefreshTokenAuthorizationRequired) ??
        Dio();

    try {
      response = await dio
          .put(
            APIRoutes.baseUrl + url,
            data: data,
          )
          .timeout(timeoutDuration);
      apiResponse = await returnResponse<T>(response);
    } catch (err) {
      apiResponse = exceptionHandler<T>(err);
    } finally {}

    return apiResponse;
  }

// DELETE Request
  Future<APIResponse<T>?> deleteRequest<T>(String url,
      {dynamic data,
      Map<String, dynamic>? header,
      dynamic id,
      bool? isAuthorizationRequired,
      bool isRefreshTokenAuthorizationRequired = false,
      bool isMediaAuthorizationRequired = false}) async {
    if (data == null ||
        data == "" ||
        data == '' ||
        data == " " ||
        data == ' ') {
      data = {};
    }
    Response response;
    APIResponse<T>? apiResponse;

    try {
      Dio dio = getDio(
              isAuthorizationRequired: isAuthorizationRequired,
              isMediaAuthorizationRequired: isMediaAuthorizationRequired,
              isRefreshTokenAuthorizationRequired:
                  isRefreshTokenAuthorizationRequired) ??
          Dio();

      response = await dio
          .delete(
            APIRoutes.baseUrl + url,
            data: data,
          )
          .timeout(timeoutDuration);
      apiResponse = await returnResponse<T>(response);
    } catch (err) {
      apiResponse = exceptionHandler<T>(
        err,
      );
    } finally {}

    return apiResponse;
  }

  Future<APIResponse<T>?> returnResponse<T>(Response? response) async {
    try {
      Response resp = response ?? Response(requestOptions: RequestOptions());
      return APIResponse<T>(
        completeResponse: resp.data,
        isSuccess:
            resp.statusCode == 200 || resp.statusCode == 201 ? true : false,
      );
    } on SocketException {
      return APIResponse<T>(
        isSuccess: false,
        data: null,
      );
    }
  }

  APIResponse<T> exceptionHandler<T>(ex, {bool? isResponseBytes = false}) {
    if (ex is DioException) {
      if (isResponseBytes == false) {
        ErrorResponseModel errorResponseModel = ex.response?.data.isEmpty
            ? ErrorResponseModel(
                errorResponse: Error(
                    errorDescription: _messageConstants.errorMessage.i18n()),
              )
            : ErrorResponseModel.fromJson(ex.response?.data);

        return APIResponse(isSuccess: false, error: errorResponseModel);
      } else {
        // If response is in bytes and some error is encountered, we first need to convert the bytes into string.
        // That will give us the json string, which can then be de-serialized using .fromJson() function.
        const asciiDecoder = AsciiDecoder();
        final asciiValues = ex.response?.data;
        final result = asciiDecoder.convert(asciiValues);

        HelperFunctions()
            .logger("byte to json error response >>>>>> ${jsonDecode(result)}");

        ErrorResponseModel errorResponseModel = ex.response?.data.isEmpty
            ? ErrorResponseModel(
                errorResponse: Error(
                    errorDescription: _messageConstants.errorMessage.i18n()),
              )
            : ErrorResponseModel.fromJson(jsonDecode(result));

        return APIResponse(isSuccess: false, error: errorResponseModel);
      }
    } else if (ex is SocketException) {
      return APIResponse<T>(
        isSuccess: false,
        data: null,
      );
    } else if (ex is TimeoutException) {
      return APIResponse<T>(
        isSuccess: false,
        data: null,
      );
    } else {
      return APIResponse<T>(
        isSuccess: false,
        data: null,
      );
    }
  }
}

typedef ResponseCallback = Future<Response> Function();
