import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerForm1ViewModel extends BaseViewModel {
  int count = 1;
  final imageConstants = ImageConstants();
  TextEditingController uploadInvoiceController = TextEditingController();
}
