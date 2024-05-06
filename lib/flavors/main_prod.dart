import 'package:flutter/material.dart';
import '../constants/api_constant.dart';
import '../constants/enums/api_environments.dart';
import 'main_common.dart';

void main() {
  // Setting the base url as per the corresponsing flavor
  APIRoutes.baseUrl = ApiEnvironments.prod.baseUrl;

  runApp(const MyApp());
}
