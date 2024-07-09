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
}
