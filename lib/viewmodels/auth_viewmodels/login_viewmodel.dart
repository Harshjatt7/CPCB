import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/routes_constant.dart';
import '../material_app_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController userTypeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? selectedUserType;
  bool isObscure = false;
  bool isBtnEnabled = false;
  UserTypes? currentUser;

  void getCurrentUserType(BuildContext context) {
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  final List<String> userTypes = [
    "Admin",
    "Other Users (SPCB, Auditor, RD’S) ",
    "Inspection",
    "Producer",
    "Retreader",
    "Recycler",
    "Custom"
  ];

  bool isEnabled() {
    isBtnEnabled = (emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        selectedUserType != null);
    notifyListeners();
    return isBtnEnabled;
  }

  void onUserTypeChanged(dynamic value) {
    selectedUserType = value;
    notifyListeners();
  }

  void onLoginButtonTapped(BuildContext context, UserTypes userType) {
    switch (userType) {
      case UserTypes.admin:
        Navigator.pushNamed(context, AppRoutes.producerHomeScreenRoute);
        break;
      case UserTypes.other:
        Navigator.pushNamed(context, AppRoutes.producerHomeScreenRoute);
        break;
      case UserTypes.inspection:
        Navigator.pushNamed(context, AppRoutes.producerHomeScreenRoute);
        break;
      case UserTypes.producer:
        Navigator.pushNamed(context, AppRoutes.producerHomeScreenRoute);
        break;
      case UserTypes.recycler:
        Navigator.pushNamed(context, AppRoutes.producerHomeScreenRoute);
        break;
      case UserTypes.retreader:
        Navigator.pushNamed(context, AppRoutes.retraderHomeScreenRoute);
        break;
      case UserTypes.custom:
        Navigator.pushNamed(context, AppRoutes.producerHomeScreenRoute);
        break;
    }
  }
}
