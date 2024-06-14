import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/custom/custom_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../views/widgets/components/download_certificate_bottom_sheet.dart';

class CustomDashboardViewModel extends BaseViewModel {
  StringConstants stringConstants = StringConstants();
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final _customRepository = CustomRepository();
  final _helperFunctions = HelperFunctions();

  Future getCustomDownloadCertificate(BuildContext context) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _customRepository.getDownloadCertificate(
          "eyJpdiI6InFucjVDNnQ5TUZFNWhKeFAvYURKemc9PSIsInZhbHVlIjoiL0lLdXRERy8xSVVaYmpuR09oNkVYQT09IiwibWFjIjoiNDRiMzg3NDVlMWEzZjMwMjQxZjY4MzJmOTk5NDk3MzZlMWJjYmZmZGFhOTQ2ZTQyNmJmMDQ1ZTE4YjA5OTNjOSIsInRhZyI6IiJ9");
      if (value.isSuccess == true) {
        _helperFunctions.downloadAndStoreFile(
            name: "Certificate", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;

        if (context.mounted) {
          _helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      _helperFunctions.logger("$err");
    }
    state = ViewState.idle;

    return null;
  }

  void downloadCertificate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return DownloadCertificateBottomSheet(
          onDownloadCertificateTapped: () async {
            if (ctx.mounted) {
              Navigator.pop(ctx);
            }
            await getCustomDownloadCertificate(context);
          },
        );
      },
    );
  }
}
