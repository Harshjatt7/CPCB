import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/routes_constant.dart';

class ProducerViewModel extends BaseViewModel {
  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.producerRoute);
    }
  }
}
