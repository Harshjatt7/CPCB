import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

class DashboardViewModel extends BaseViewModel {
  UserTypes? currentUser;
  void getCurrentUserType(BuildContext context) {
    currentUser = MaterialAppViewModel.userTypeEnum;
  }
}
