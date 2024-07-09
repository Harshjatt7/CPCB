import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerForm4ViewModel extends BaseViewModel {
  TextEditingController invoiceController = TextEditingController();
  TextEditingController remakrsInvoiceController = TextEditingController();
  TextEditingController buyersController = TextEditingController();
  TextEditingController remakrsBuyerController = TextEditingController();

  String radioInvoice = 'confirmed';
  String radioBuyer = 'confirmed';
  final MessageConstant messageConstant = MessageConstant();

  String? invoicesRemarkValidation() {
    if (remakrsInvoiceController.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

  String? buyersRemarkValidation() {
    if (remakrsBuyerController.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

  String? invoiceValidation() {
    return Validations().gstValidation(invoiceController.text);
  }

  String? buyersValidation() {
    return Validations().gstValidation(buyersController.text);
  }
}
