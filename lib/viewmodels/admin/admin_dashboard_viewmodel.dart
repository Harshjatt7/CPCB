
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/controllers/admin/admin_repository.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AdminDashBoardViewmodel extends BaseViewModel {
  
  final _adminRepo = AdminRepository();
  APIResponse<EprApplicationResponseModel?>? _eprApplicationResponseModel;
  APIResponse<EprApplicationResponseModel?>? get eprApplicationResponseModel =>
      _eprApplicationResponseModel;


  EPRApplicationData? producerData;
  EPRApplicationData? recyclerData;
  EPRApplicationData? retraderData;

  Future<APIResponse<EprApplicationResponseModel?>?> getAdminDashBoardData(
      BuildContext context) async {
    state = ViewState.busy;

    try {
      APIResponse<EprApplicationResponseModel?>? producerRes =
          await _adminRepo.getAdminDashBoard(
              "producer");
      var recyclerRes = await _adminRepo.getAdminDashBoard(
          "recycler");
      var retraderRes = await _adminRepo.getAdminDashBoard(
          "retreader");

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

  
}
