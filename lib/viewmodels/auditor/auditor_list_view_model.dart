import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AuditorListViewModel extends BaseViewModel {
  TextEditingController searchController = TextEditingController();
  bool isSearchExpanded = false;
  String? groupValue = 'no';
  final appColor = AppColor();
  final stringConstants = StringConstants();
}
