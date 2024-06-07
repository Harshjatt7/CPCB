import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../views/widgets/components/download_certificate_bottom_sheet.dart';

class CustomDashboardViewModel extends BaseViewModel {
  StringConstants stringConstants = StringConstants();
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void downloadCertificate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return DownloadCertificateBottomSheet();
      },
    );
  }
}
