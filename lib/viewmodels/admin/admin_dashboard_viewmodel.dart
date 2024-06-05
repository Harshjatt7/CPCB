import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/controllers/admin/admin_repository.dart';
import 'package:cpcb_tyre/models/response/admin/common_epr_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AdminDashBoardViewmodel extends BaseViewModel {
  final _adminRepo = AdminRepository();
  APIResponse<EprApplicationResponseModel?>? _eprApplicationResponseModel;
  APIResponse<EprApplicationResponseModel?>? get eprApplicationResponseModel =>
      _eprApplicationResponseModel;
  APIResponse<EprOblicationsResponseModel?>? _eprOblicationResponseModel;
  APIResponse<EprOblicationsResponseModel?>? get eproblicationResponseModel =>
      _eprOblicationResponseModel;

  APIResponse<CommonEprOblicationsResponseModel?>?
      _commonEprOblicationsResponseModel;
  APIResponse<CommonEprOblicationsResponseModel?>?
      get commonEprOblicationsResponseModel =>
          _commonEprOblicationsResponseModel;

  EPRApplicationData? producerData;
  EPRApplicationData? recyclerData;
  EPRApplicationData? retraderData;
  EprOblicationsData? producerEprOblicationsData;
  CommonEprOblicationData? retreaderEprOblicationData;
  CommonEprOblicationData? recyclerEprOblicationData;

  Future<APIResponse<EprApplicationResponseModel?>?> getAdminDashBoardData(
      BuildContext context) async {
    state = ViewState.busy;
    try {
      APIResponse<EprApplicationResponseModel?>? producerRes =
          await _adminRepo.getAdminDashBoard(AdminUserTypes.producer.text);
      var recyclerRes =
          await _adminRepo.getAdminDashBoard(AdminUserTypes.recycler.text);
      var retraderRes =
          await _adminRepo.getAdminDashBoard(AdminUserTypes.retreader.text);

      if (producerRes?.isSuccess == true) {
        producerRes?.data =
            EprApplicationResponseModel.fromJson(producerRes.completeResponse);

        producerData = producerRes?.data?.eprApplicationData;
      }

      if (recyclerRes?.isSuccess == true) {
        recyclerRes?.data =
            EprApplicationResponseModel.fromJson(recyclerRes.completeResponse);

        recyclerData = recyclerRes?.data?.eprApplicationData;
      }
      if (retraderRes?.isSuccess == true) {
        retraderRes?.data =
            EprApplicationResponseModel.fromJson(retraderRes.completeResponse);

        retraderData = retraderRes?.data?.eprApplicationData;
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return _eprApplicationResponseModel;
  }

  Future<APIResponse<EprOblicationsResponseModel?>?> getEprOblications(
      BuildContext context) async {
    state = ViewState.busy;

    try {
      _eprOblicationResponseModel = await _adminRepo.getEprOblications();
      if (_eprOblicationResponseModel?.isSuccess == true) {
        _eprOblicationResponseModel?.data =
            EprOblicationsResponseModel.fromJson(
                _eprOblicationResponseModel?.completeResponse);
        producerEprOblicationsData = _eprOblicationResponseModel?.data?.data;
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

    return _eprOblicationResponseModel;
  }

  Future<APIResponse<CommonEprOblicationsResponseModel?>?>
      getCommonEprOblications(BuildContext context) async {
    state = ViewState.busy;

    try {
      APIResponse<CommonEprOblicationsResponseModel?>? recyclerRes =
          await _adminRepo.getCommonEprOblications("recycler");
      var retraderRes = await _adminRepo.getCommonEprOblications("retreader");

      if (recyclerRes?.isSuccess == true) {
        recyclerRes?.data = CommonEprOblicationsResponseModel.fromJson(
            recyclerRes.completeResponse);

        recyclerEprOblicationData = recyclerRes?.data?.data;
      }
      if (retraderRes?.isSuccess == true) {
        retraderRes?.data = CommonEprOblicationsResponseModel.fromJson(
            retraderRes.completeResponse);

        retreaderEprOblicationData = retraderRes?.data?.data;
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return _commonEprOblicationsResponseModel;
  }
}
