import 'package:flutter/material.dart';

class TabBarModel {
  final Widget tab;
  final String label;
  final VoidCallback? onTap;

  TabBarModel({required this.tab, required this.label,this.onTap});
}
