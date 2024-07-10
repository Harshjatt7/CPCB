import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerProcurementViewModel extends BaseViewModel{
  final appColor = AppColor();
  TextEditingController searchController = TextEditingController();
  bool isSearchExpanded = false;

}