import 'package:flutter/material.dart';
import 'package:cpcb_tyre/flavors/main_common.dart';
import '../constants/api_constant.dart';
import '../constants/enums/api_environments.dart';

void main() {
  // Setting the base url as per the corresponsing flavor
  APIRoutes.baseUrl = ApiEnvironments.dev.baseUrl;

  runApp(const MyApp());
}
