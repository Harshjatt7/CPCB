import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AuditorListViewModel extends BaseViewModel {
  TextEditingController searchController = TextEditingController();
  bool isSearchExpanded = false;
  String groupValue = 'no';
  final appColor = AppColor();
  final stringConstants = StringConstants();
  String? applicationStatus = "";
  double? progress;

  getStatus(String status) {
    switch (status) {
      case "In Progress":
        applicationStatus = AuditorStatus.resume.text;
        break;
      case "Open":
        applicationStatus = AuditorStatus.acknowledge.text;
        break;
      case "Scheduled":
        applicationStatus = AuditorStatus.start.text;
        break;
      case "Completed":
        applicationStatus = AuditorStatus.viewReport.text;
        break;
      default:
        applicationStatus = AuditorStatus.start.text;
        break;
    }
    updateUI();
  }
}

