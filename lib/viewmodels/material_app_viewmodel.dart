import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';

import '../flavors/main_common.dart';

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

  void updateUserType(String userType, BuildContext context) async {
    await HelperFunctions().setUserType(userType, context);
  }

  Future<void> getUserType(BuildContext context) async {
    await HelperFunctions().getUserType(context);
  }
}
