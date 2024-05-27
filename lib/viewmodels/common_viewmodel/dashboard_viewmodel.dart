import 'dart:io';

import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/controllers/common/common_repository.dart';
import 'package:cpcb_tyre/models/response/common/dashboard_response_model.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/enums/state_enums.dart';
import '../../models/response/base_response_model.dart';
import '../../utils/helper/helper_functions.dart';

class DashboardViewModel extends BaseViewModel {
  final _apiRoutes = APIRoutes();
  final _commonRepo = CommonRepository();

  UserTypes? currentUser;
  APIResponse<DashboardResponseModel?>? _dashboardResponseModel;
  APIResponse<DashboardResponseModel?>? get dashboardResponseModel =>
      _dashboardResponseModel;
  DashboardData? data;
  String? url;

  void getCurrentUserType(BuildContext context) async {
    await HelperFunctions().getUserType(context);
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  Future<APIResponse<DashboardResponseModel?>?> getDasboardData(
      BuildContext context) async {
    state = ViewState.busy;

    try {
      _dashboardResponseModel =
          await _commonRepo.getDasboardData(getUrl() ?? "");
      if (_dashboardResponseModel?.isSuccess == true) {
        _dashboardResponseModel?.data = DashboardResponseModel.fromJson(
            _dashboardResponseModel?.completeResponse);
        data = _dashboardResponseModel?.data?.data;
      } else {
        if (context.mounted) {
          HelperFunctions().commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return _dashboardResponseModel;
  }

  Future getDownloadPaymentReceipt(BuildContext context) async {
    state = ViewState.busy;
    try {
      final value = await _commonRepo
          .getDownloadPaymentReceipt(getPaymentReceiptAPIUrl() ?? '');
      if (value != null) {
        final Directory? appDir = Platform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory();
        String tempPath = appDir!.path;

        String fileName = 'Payment Receipt (${DateTime.timestamp()}).pdf';
        File file = File('$tempPath/$fileName');
        if (!await file.exists()) {
          await file.create(recursive: true);
        }
        await file.writeAsBytes(value.completeResponse);
        HelperFunctions().logger(file.path);
        await openFile(file.path);
      }

      state = ViewState.idle;
      return value;
    } catch (err) {
      HelperFunctions().logger("$err");
    }
    state = ViewState.idle;

    return null;
  }

  Future getDownloadApplication(BuildContext context) async {
    state = ViewState.busy;
    try {
      final value = await _commonRepo
          .getDownloadApplication(getDownloadApplicationAPIUrl() ?? '');
      if (value != null) {
        final Directory? appDir = Platform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory();
        String tempPath = appDir!.path;

        String fileName =
            'Application${DateTime.timestamp().millisecond}${DateTime.timestamp().microsecond}.pdf';
        File file = File('$tempPath/$fileName');
        if (!await file.exists()) {
          await file.create(recursive: true);
        }
        await file.writeAsBytes(value.completeResponse);
        HelperFunctions().logger(file.path);
        await openFile(file.path);
      }
      state = ViewState.idle;
      return value;
    } catch (err) {
      HelperFunctions().logger("$err");
    }
    state = ViewState.idle;
    return null;
  }

  Future openFile(String url) async {
    return await OpenFile.open(url);
  }

  String? getPaymentReceiptAPIUrl() {
    switch (MaterialAppViewModel.userTypeEnum) {
      case UserTypes.producer:
        return _apiRoutes.downloadProducerPaymentReciptAPIRoute;
      case UserTypes.recycler:
        return _apiRoutes.downloadRecyclerPaymentReciptAPIRoute;
      case UserTypes.retreader:
        return _apiRoutes.downloadRetreaderPaymentReciptAPIRoute;
      case UserTypes.inspection:
        return '';
      case UserTypes.admin:
        return '';
      case UserTypes.custom:
        return '';
      case UserTypes.other:
        return '';
      default:
        return null;
    }
  }

  String? getDownloadApplicationAPIUrl() {
    switch (MaterialAppViewModel.userTypeEnum) {
      case UserTypes.producer:
        return '';
      case UserTypes.recycler:
        return '';
      case UserTypes.retreader:
        return _apiRoutes.retreaderDownloadApplicationAPIRoute;
      case UserTypes.inspection:
        return '';
      case UserTypes.admin:
        return '';
      case UserTypes.custom:
        return '';
      case UserTypes.other:
        return '';
      default:
        return null;
    }
  }

  String? getUrl() {
    switch (MaterialAppViewModel.userTypeEnum) {
      case UserTypes.producer:
        return _apiRoutes.producerDashboardAPIRoute;
      case UserTypes.recycler:
        return _apiRoutes.recyclerDashboardAPIRoute;
      case UserTypes.retreader:
        return _apiRoutes.retreaderDashboardAPIRoute;
      case UserTypes.inspection:
        return '';
      case UserTypes.admin:
        return '';
      case UserTypes.custom:
        return '';
      case UserTypes.other:
        return '';
      default:
        return null;
    }
  }
}
