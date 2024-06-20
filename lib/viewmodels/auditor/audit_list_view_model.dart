//auditor's viewModel

import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AuditListViewModel extends BaseViewModel {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController previousStartDateController = TextEditingController();
  TextEditingController previousEndDateController = TextEditingController();
  void assignTextEditingControllers() {
    previousStartDateController.text = "2024/02/10";
    previousEndDateController.text = "2024/02/10";
  }
}
