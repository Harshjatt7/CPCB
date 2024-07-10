import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerForm3ViewModel extends BaseViewModel {
  TextEditingController aContactController = TextEditingController();
  TextEditingController aContactRemarksController = TextEditingController();
  TextEditingController aVerifiedController = TextEditingController();
  TextEditingController aVerifiedRemakrsController = TextEditingController();
  TextEditingController aNotVerifiedController = TextEditingController();
  TextEditingController bContactController = TextEditingController();
  TextEditingController bContactRemarksController = TextEditingController();
  TextEditingController bVerifiedController = TextEditingController();
  TextEditingController bVerifiedRemakrsController = TextEditingController();
  TextEditingController bNotVerifiedController = TextEditingController();

  String radioAContact = 'confirmed';
  String radioAVerified = 'confirmed';
  String radioBContact = 'confirmed';
  String radioBVerified = 'confirmed';
  final MessageConstant messageConstant = MessageConstant();

  String? numericValidation(TextEditingController controller) {
    return Validations().numberValidation(controller.text);
  }

  String? invoicesRemarkValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

  void textFormListener() {
    aContactController.addListener(() {
      totalValueA();
    });
    aVerifiedController.addListener(() {
      totalValueA();
    });
    bContactController.addListener(() {
      totalValueB();
    });
    bVerifiedController.addListener(() {
      totalValueB();
    });
  }

  void totalValueA() {
    int supplierContact = int.parse(
        aContactController.text.isEmpty ? "0" : aContactController.text);
    int verified = int.parse(
        aVerifiedController.text.isEmpty ? "0" : aVerifiedController.text);
    if (aContactController.text.isNotEmpty ||
        aVerifiedController.text.isNotEmpty) {
      aNotVerifiedController.text = (supplierContact - verified).toString();
    }
  }

  void totalValueB() {
    int supplierContact = int.parse(
        bContactController.text.isEmpty ? "0" : bContactController.text);
    int verified = int.parse(
        bVerifiedController.text.isEmpty ? "0" : bVerifiedController.text);
    if (bContactController.text.isNotEmpty ||
        bVerifiedController.text.isNotEmpty) {
      bNotVerifiedController.text = (supplierContact - verified).toString();
    }
  }
}
