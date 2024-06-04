import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AdminApplicationViewModel extends BaseViewModel {
  TextEditingController searchController = TextEditingController();
  bool isSearchExpanded = false;

  void searchRetreader(String value) {}
  void getUpdatedList() {}
}
