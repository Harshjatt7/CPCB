import 'dart:async';
import 'dart:io';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/models/response/auth/login_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cpcb_tyre/models/response/error_response_model.dart';
import 'package:localization/localization.dart';
import '../constants/api_constant.dart';
import '../models/response/base_response_model.dart';
import '../utils/helper/debouncing_helper.dart';
import '../viewmodels/material_app_viewmodel.dart';

class APIBase {
  Dio? _dio;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Duration timeoutDuration = const Duration(seconds: 60);
  static final debouncer = Debouncer(milliseconds: 1000);

  Dio? getDio(
      {bool? isAuthorizationRequired = false,
      bool? isRefreshTokenAuthorizationRequired = false}) {
    _dio = Dio(BaseOptions(
      baseUrl: APIRoutes.baseUrl,
      connectTimeout: timeoutDuration,
      receiveTimeout: timeoutDuration,
    ));

    if (isAuthorizationRequired == true) {
      _dio?.interceptors.add(authorizationInterceptor);
    } else if (isRefreshTokenAuthorizationRequired == true) {
      _dio?.interceptors.add(refreshTokenAuthorizationInterceptor);
    } else {
      _dio?.interceptors.add(noAuthorizationInterceptor);
    }

    return _dio;
  }

  // Interceptor for non authorized API calls
  var noAuthorizationInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      // options.headers['Content-Type'] = "application/json";
      // // options.headers['Accept'] = "*/*";
      // options.headers['Connection'] = "keep-alive";

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

      HelperFunctions().logger("token ?>>> $token");

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
            return handler.resolve(await Dio().fetch(error.requestOptions));
          }
        });

        //if()
      } else {
        return handler.next(error);
      }
    },
  );

  // Interceptor for authorized API calls
  var refreshTokenAuthorizationInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      String? token;
      await HelperFunctions().getRefreshToken();

      token = MaterialAppViewModel.refreshToken;

      options.headers["Accept"] = "application/json";

      // options.headers['Content-Type'] = "application/json";
      // options.headers['Accept'] = "*/*";
      // options.headers['Connection'] = "keep-alive";
      // op
      // options.headers['X-CSRF-TOKEN'] = "";
      //options.headers['Accept-Encoding'] = "gzip, deflate, br";
      options.headers['Authorization'] =
          //"";
          "Bearer $token";

      HelperFunctions().logger("token ?>>> $token");

      return handler.next(options);
    },
    onError: (error, handler) async {
      // if (error.response?.statusCode == 401) {
      //   // Handle refresh token here.
      //   await HelperFunctions().getRefreshToken();
      //   // error.requestOptions.headers["Authorization"] =
      //   //     "Bearer ${MaterialAppViewModel.refreshToken}";

      //   var res = await MaterialAppViewModel().getRefreshToken();

      //   if (res?.isSuccess == false) {
      //     HelperFunctions().logger("message");
      //     return handler.reject(error);
      //   } else {
      //     return handler.resolve(await Dio().fetch(error.requestOptions));
      //   }

      //   //if()
      // } else {
      //   return handler.next(error);
      // }
    },
  );

// GET $Request
  Future<APIResponse<T>?> getRequest<T>(
    String url, {
    bool isAuthorizationRequired = false,
  }) async {
    Response response;
    APIResponse<T>? apiResponse;
    Dio dio = getDio(
          isAuthorizationRequired: isAuthorizationRequired,
        ) ??
        Dio();

    try {
      response = await dio
          .get(
            APIRoutes.baseUrl + url,
          )
          .timeout(timeoutDuration);

      apiResponse = await returnResponse<T>(response);
    } catch (err) {
      apiResponse = exceptionHandler<T>(err);
    } finally {}

    return apiResponse;
  }

// POST Request
  Future<APIResponse<T>?> postRequest<T>(String url,
      {dynamic data,
      bool isAuthorizationRequired = false,
      bool isRefreshTokenAuthorizationRequired = false}) async {
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
        ) ??
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
  Future<APIResponse<T>?> patchRequest<T>(
    String url,
    dynamic data, {
    bool isAuthorizationRequired = false,
  }) async {
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
        ) ??
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
  Future<APIResponse<T>?> putRequest<T>(
    String url,
    dynamic data, {
    bool isAuthorizationRequired = false,
  }) async {
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
        ) ??
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
  Future<APIResponse<T>?> deleteRequest<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? header,
    dynamic id,
    bool? isAuthorizationRequired,
  }) async {
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
      Dio dio =
          getDio(isAuthorizationRequired: isAuthorizationRequired) ?? Dio();

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
        isSuccess: (resp.data['status'] == 200 || resp.data['status'] == 201)
            ? true
            : resp.statusCode == 200
                ? true
                : false,
      );
    } on SocketException {
      return APIResponse<T>(
        isSuccess: false,
        data: null,
      );
    }
  }

  APIResponse<T> exceptionHandler<T>(ex) {
    if (ex is DioException) {
      ErrorResponseModel errorResponseModel = ex.response?.data.isEmpty
          ? ErrorResponseModel(
              errorResponse: Error(
                  errorDescription: MessageConstant().errorMessage.i18n()),
            )
          : ErrorResponseModel.fromJson(ex.response?.data);

      return APIResponse(isSuccess: false, error: errorResponseModel);
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
