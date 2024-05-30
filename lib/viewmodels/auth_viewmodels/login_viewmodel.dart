import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/utils/helper/global_provider_helper.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../constants/enums/state_enums.dart';
import '../../constants/routes_constant.dart';
import '../../controllers/auth/auth_repository.dart';
import '../../models/request/login_request_model.dart';
import '../../models/response/base_response_model.dart';
import '../../models/response/auth/login_response_model.dart';
import '../../utils/helper/helper_functions.dart';
import '../material_app_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController userTypeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? selectedUserType;
  String? userTypeDropdownError;
  String? changeDropdown;
  bool isObscure = true;

  bool isBtnEnabled = false;
  UserTypes? currentUser;
  final _authRepo = AuthRepository();

  void getCurrentUserType(BuildContext context) {
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  final List<String> userTypes = [
    StringConstants.admin,
    StringConstants.auditor,
    StringConstants.spcb,
    StringConstants.inspection,
    StringConstants.producer,
    StringConstants.retreader,
    StringConstants.recycler,
    StringConstants.custom
  ];

  bool isEnabled() {
    isBtnEnabled = (emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        (formKey.currentState?.validate() ?? false) &&
        selectedUserType != null);
    notifyListeners();
    return isBtnEnabled;
  }

  void dropDownValidation() {
    if (selectedUserType == null) {
      onUserTypeChanged(null);
    }
  }

  String? selectedUserTypeError;
  void onUserTypeChanged(newValue) {
    selectedUserType = newValue;
    updateUI();
    if (selectedUserType == null) {
      selectedUserTypeError = "Please select the value";
      updateUI();
    }
  }

  Future<void> onLoginButtonTapped(
      BuildContext context, LoginRequestModel request) async {
    APIResponse<LoginResponseModel>? res;
    if (context.mounted) {
      if (formKey.currentState?.validate() ?? false) {
        await context.globalProvider
            .updateUserType(selectedUserType ?? "", context);

        if (context.mounted) {
          res = await login(context, request);
        }

        if (context.mounted && res?.isSuccess == true) {
          HelperFunctions().logger(
              "res?.data?.data?.refreshToken >> ${res?.data?.data?.refreshToken}");
          HelperFunctions()
              .logger("res?.data?.data?.token >> ${res?.data?.data?.token}");
          switch (MaterialAppViewModel.userTypeEnum ?? UserTypes.custom) {
            case UserTypes.admin:
              Navigator.pushReplacementNamed(context, '');
              break;
            case UserTypes.auditor:
              Navigator.pushReplacementNamed(context, '');
              break;
            case UserTypes.spcb:
              Navigator.pushReplacementNamed(context, '');
              break;
            case UserTypes.inspection:
              Navigator.pushReplacementNamed(context, '');
              break;
            case UserTypes.producer:
              Navigator.pushReplacementNamed(
                  context, AppRoutes.producerHomeScreenRoute);
              break;
            case UserTypes.recycler:
              Navigator.pushReplacementNamed(
                  context, AppRoutes.recyclerHomeScreenRoute);
              break;
            case UserTypes.retreader:
              Navigator.pushReplacementNamed(
                  context, AppRoutes.retraderHomeScreenRoute);
              break;
            case UserTypes.custom:
              Navigator.pushReplacementNamed(context, '');
              break;
          }
        } else {
          if (context.mounted) {
            HelperFunctions().logger(
                "res?.error?.errorResponse?.errorDescription >> ${res?.error?.errorResponse?.errorDescription}");
            HelperFunctions().commonErrorSnackBar(
                context,
                res?.error?.errorResponse?.errorDescription ??
                    MessageConstant().errorMessage.i18n());
          }
        }
      }
    }
  }

  Future<APIResponse<LoginResponseModel>?> login(
      BuildContext context, LoginRequestModel request) async {
    state = ViewState.busy;
    APIResponse<LoginResponseModel>? response;

    try {
      response = await _authRepo.login(request);
      if (response?.isSuccess == true) {
        // Any logic that needs to be implemented after successful login.
        response?.data = LoginResponseModel.fromJson(response.completeResponse);

        await HelperFunctions().storeToken(response?.data?.data?.token ?? "");
        await HelperFunctions()
            .storeRefreshToken(response?.data?.data?.refreshToken ?? "");

        if (context.mounted) {
          await HelperFunctions().setLoginStatus(context, true);
        }
      } else {
        // Any logic that needs to be implemented after un-successful login.
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return response;
  }

  void changeDropdownValue(newValue) {
    changeDropdown = newValue;
    if (changeDropdown == null) {
      userTypeDropdownError = MessageConstant().pleaseSelectDropdownValue;
    }
    updateUI();
  }

  String? emailValidation() {
    return Validations().validateEmail(emailController.text);
  }

  String? passValidation() {
    return Validations().validatePassword(passController.text);
  }
}
