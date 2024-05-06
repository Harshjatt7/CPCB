import 'package:flutter/material.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:provider/provider.dart';

extension GlobalProviderHelper on BuildContext {
  /// returns localized string of the specified key.
  MaterialAppViewModel get globalProvider {
    // if no locale was found, returns a default
    return Provider.of<MaterialAppViewModel>(this, listen: false);
  }
}
