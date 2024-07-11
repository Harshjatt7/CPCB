import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/common/common_repository.dart';
import 'package:cpcb_tyre/models/response/common/dashboard_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_list_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
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

  void testPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return
          
           Padding(
            padding: const EdgeInsets.only(top: 160, left: 16, right: 16,bottom: 50),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CommonImageWidget(
                                height: 50,
                                fit: BoxFit.contain,
                                imageSource: ImageConstants().blueLogo,
                                isNetworkImage: false),
                          ),
                          const Flexible(
                            child: CommonTitleWidget(
                              label:
                                  "EPR Portal for Tyre Waste Management System",
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: appColor.black10,
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: CommonTitleWidget(label: "Welcome")),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ProducerListTile(
                          title: stringConstants.userType, subtitle: ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ProducerListTile(
                          title: stringConstants.currentStatus, subtitle: ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(color: appColor.grey20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              text: "Note*  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(color: appColor.green),
                              children: [
                                TextSpan(
                                  text:
                                      "You have to complete the registration process to access your dashboard, Click on the “Initiate Registration” to start the process on web portal",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: appColor.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CommonButtonWidget(
                      label: "Initiate Registration",
                      color: appColor.darkGreen,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          );
       
       
        });
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
