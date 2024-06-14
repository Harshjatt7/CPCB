import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/custom/custom_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/custom/custom_response_model.dart';
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
  APIResponse<CustomResponseModel?>? _customResponseModel;
  APIResponse<CustomResponseModel?>? get customResponseModel =>
      _customResponseModel;
  int page = 1;
  List<CustomData>? data;

  Future getCustomDownloadCertificate(BuildContext context, String id) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _customRepository.getDownloadCertificate(id);
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

  void downloadCertificate(BuildContext context, String? id) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) {
        return DownloadCertificateBottomSheet(
          onDownloadCertificateTapped: () async {
            if (ctx.mounted) {
              Navigator.pop(ctx);
            }
            await getCustomDownloadCertificate(context, id ?? '');
          },
        );
      },
    );
  }

  Future<APIResponse<CustomResponseModel?>?> getCustomData(
      {bool? isPaginating = false}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _customResponseModel =
          await _customRepository.getCustomData(page: "$page");
      if (_customResponseModel?.isSuccess == true) {
        _customResponseModel?.data = CustomResponseModel.fromJson(
            _customResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_customResponseModel?.data?.data ?? []);
        } else {
          data = _customResponseModel?.data?.data ?? [];
        }
      } else {
        _helperFunctions.logger("No response");
      }
    } catch (err) {
      _helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _customResponseModel;
  }
}
