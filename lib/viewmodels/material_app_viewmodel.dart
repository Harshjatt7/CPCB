import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/controllers/auth/auth_repository.dart';
import 'package:cpcb_tyre/models/response/auth/login_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';

import '../flavors/main_common.dart';
import '../models/request/refresh_token_request_model.dart';
import '../models/response/base_response_model.dart';

class MaterialAppViewModel extends BaseViewModel {
  int count = 1;

  void changeLanguage(BuildContext context) async {
    if (MyApp.of(context)!.localeName == 'en') {
      MyApp.of(context)!.setLocale(const Locale('es'));
    } else {
      MyApp.of(context)!.setLocale(const Locale('en'));
    }
  }

  String userType = "";
  static UserTypes? userTypeEnum;
  static String? token;
  static String? refreshToken;
  bool isLogin = false;

  Future<void> updateUserType(String userType, BuildContext context) async {
    await HelperFunctions().setUserType(userType, context);
  }

  Future<void> getUserType(BuildContext context) async {
    await HelperFunctions().getUserType(context);
  }

  Future<APIResponse<LoginResponseModel?>?> getRefreshToken() async {
    await HelperFunctions().getRefreshToken();

    APIResponse<LoginResponseModel?>? res = await AuthRepository().refreshToken(
        RefreshTokenRequestModel(
            refreshToken: MaterialAppViewModel.refreshToken));

    if (res?.isSuccess == true) {
      res?.data = LoginResponseModel.fromJson(res.completeResponse);
      HelperFunctions().storeToken(
          res?.data?.data?.token ?? MaterialAppViewModel.token ?? "");
    }

    return res;
  }
}
