import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/common/common_repository.dart';
import 'package:cpcb_tyre/models/response/common/dashboard_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../constants/enums/state_enums.dart';
import '../../models/response/base_response_model.dart';
import '../../utils/helper/helper_functions.dart';

class DashboardViewModel extends BaseViewModel {
  final _apiRoutes = APIRoutes();
  final _commonRepo = CommonRepository();
  final StringConstants stringConstants = StringConstants();
  final HelperFunctions helperFunctions = HelperFunctions();
  final AppColor appColor = AppColor();
  bool? isRegistered = true;

  UserTypes? currentUser;
  APIResponse<DashboardResponseModel?>? _dashboardResponseModel;
  APIResponse<DashboardResponseModel?>? get dashboardResponseModel =>
      _dashboardResponseModel;
  DashboardData? data;
  String? url;

  void getCurrentUserType(BuildContext context) async {
    await helperFunctions.getUserType(context);
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
        if (context.mounted) {
          isRegistered = data?.currentStatus == "Approved";
          updateUI();
          helperFunctions
              .logger('gdrghded $isRegistered}');
        }
      } else {
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _dashboardResponseModel;
  }

  Future getDownloadPaymentReceipt(BuildContext context) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _commonRepo
          .getDownloadPaymentReceipt(getPaymentReceiptAPIUrl() ?? '');
      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: "Transaction", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;

        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return null;
  }

  Future getDownloadApplication(BuildContext context) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _commonRepo
          .getDownloadApplication(getDownloadApplicationAPIUrl() ?? '');
      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: "Application", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return null;
  }

  Future getDownloadCertificate(BuildContext context) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _commonRepo.getDownloadCertificate();
      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: "Certificate", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? '');
        }
      }
    } catch (error) {
      helperFunctions.logger("$error");
    }
    state = ViewState.idle;
    return null;
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
      case UserTypes.auditor:
        return '';
      case UserTypes.spcb:
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
      case UserTypes.auditor:
        return '';
      case UserTypes.spcb:
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
      case UserTypes.auditor:
        return '';
      case UserTypes.spcb:
        return '';
      default:
        return null;
    }
  }
}
