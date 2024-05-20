import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/store_key_constants.dart';
import 'package:cpcb_tyre/controllers/common/common_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/profile_response_model.dart';
import 'package:cpcb_tyre/store/secure_storage.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/routes_constant.dart';

class ProfileViewModel extends BaseViewModel {
  final _commonRepo = CommonRepository();
  APIResponse<ProfileResponseModel?>? _profileResponseModel;
  APIResponse<ProfileResponseModel?>? get profileResponseModel =>
      _profileResponseModel;
  ProfileData? data;

  void clearAppData(context) async {
    await SecureStorage.instance
        .deleteSensitiveInfo(StoreKeyConstants().userType);
    await SecureStorage.instance.deleteSensitiveInfo(StoreKeyConstants().token);
    await SecureStorage.instance
        .deleteSensitiveInfo(StoreKeyConstants().refreshToken);
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().isLogin, false);
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginScreenRoute, (route) => false);
  }

  Future<APIResponse<ProfileResponseModel?>?> getProfileData() async {
    state = ViewState.busy;

    try {
      _profileResponseModel = await _commonRepo.getProfileData();
      if (_profileResponseModel?.isSuccess == true) {
        _profileResponseModel?.data = ProfileResponseModel.fromJson(
            _profileResponseModel?.completeResponse);
        data = _profileResponseModel?.data?.data;
        HelperFunctions().logger('${data?.name}');
      } else {
        HelperFunctions().logger("drfsxrfdesxfdsxf");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return _profileResponseModel;
  }
}
