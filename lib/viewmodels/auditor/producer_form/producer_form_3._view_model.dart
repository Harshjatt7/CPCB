import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../../constants/string_constant.dart';

class ProducerForm3ViewModel extends BaseViewModel {
  final helperFunctions = HelperFunctions();
  final stringConstants = StringConstants();
  final messageConstant = MessageConstant();
  String radioMisreporting = "";
  String radioInformation = "";
  TextEditingController deviationController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
}
