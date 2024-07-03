import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class AuditorDashboardViewModel extends BaseViewModel {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController previousStartDateController = TextEditingController();
  TextEditingController previousEndDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String? groupValue = 'no';
  bool isSearchExpanded = false;
  final stringConstants = StringConstants();
  final appColor = AppColor();

  void assignTextEditingControllers() {
    previousStartDateController.text = "2024/02/10";
    previousEndDateController.text = "2024/02/10";
  }
}
