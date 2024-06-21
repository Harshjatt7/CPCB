import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/admin/admin_repository.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/producer_epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AdminDashBoardViewmodel extends BaseViewModel {
  final StringConstants stringConstants = StringConstants();
  final HelperFunctions helperFunctions = HelperFunctions();
  final _adminRepo = AdminRepository();
  APIResponse<EprApplicationResponseModel?>? _eprApplicationResponseModel;
  APIResponse<EprApplicationResponseModel?>? get eprApplicationResponseModel =>
      _eprApplicationResponseModel;
  APIResponse<ProducerEprOblicationsResponseModel?>?
      _eprOblicationResponseModel;
  APIResponse<ProducerEprOblicationsResponseModel?>?
      get eproblicationResponseModel => _eprOblicationResponseModel;

  APIResponse<EprOblicationsResponseModel?>? _commonEprOblicationsResponseModel;
  APIResponse<EprOblicationsResponseModel?>?
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
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _eprApplicationResponseModel;
  }

  Future<APIResponse<ProducerEprOblicationsResponseModel?>?> getEprOblications(
      BuildContext context) async {
    state = ViewState.busy;

    try {
      _eprOblicationResponseModel = await _adminRepo.getEprOblications();
      if (_eprOblicationResponseModel?.isSuccess == true) {
        _eprOblicationResponseModel?.data =
            ProducerEprOblicationsResponseModel.fromJson(
                _eprOblicationResponseModel?.completeResponse);
        producerEprOblicationsData = _eprOblicationResponseModel?.data?.data;
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

    return _eprOblicationResponseModel;
  }

  Future<APIResponse<EprOblicationsResponseModel?>?> getCommonEprOblications(
      BuildContext context) async {
    state = ViewState.busy;

    try {
      APIResponse<EprOblicationsResponseModel?>? recyclerRes =
          await _adminRepo.getCommonEprOblications("recycler");
      var retraderRes = await _adminRepo.getCommonEprOblications("retreader");

      if (recyclerRes?.isSuccess == true) {
        recyclerRes?.data =
            EprOblicationsResponseModel.fromJson(recyclerRes.completeResponse);

        recyclerEprOblicationData = recyclerRes?.data?.data;
      }
      if (retraderRes?.isSuccess == true) {
        retraderRes?.data =
            EprOblicationsResponseModel.fromJson(retraderRes.completeResponse);

        retreaderEprOblicationData = retraderRes?.data?.data;
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _commonEprOblicationsResponseModel;
  }

  num? totalEprObligations() {
    final data = producerEprOblicationsData;
    num? total = (data?.newTyreImported ?? 0) +
        (data?.wasteTyreImported ?? 0) +
        (data?.newTyreImportedAndImportedVehicles ?? 0) +
        (data?.newTyreImportedExclusivelyForNewVehiclesManufacturedDomestically ??
            0) +
        (data?.newTyreManufacturers ?? 0) +
        (data?.newTyreProducedDomestically ?? 0);
    if (total == 0) {
      return null;
    }

    return total;
  }

  num? totalRecyclerGenerated() {
    final data = recyclerEprOblicationData;
    num? total = (data?.crumbRubber?.earnedCredit ?? 0) +
        (data?.crumbRubberModifiedBitumenCrmb?.earnedCredit ?? 0) +
        (data?.reclaimedRubber?.earnedCredit ?? 0) +
        (data?.recoverCarbon?.earnedCredit ?? 0) +
        (data?.retreadedTyre?.earnedCredit ?? 0) +
        (data?.tpoChar?.earnedCredit ?? 0);
    return total;
  }

  num? totalRecyclerTransferred() {
    final data = recyclerEprOblicationData;
    num? total = (data?.crumbRubber?.creditTransfered ?? 0) +
        (data?.crumbRubberModifiedBitumenCrmb?.creditTransfered ?? 0) +
        (data?.reclaimedRubber?.creditTransfered ?? 0) +
        (data?.recoverCarbon?.creditTransfered ?? 0) +
        (data?.retreadedTyre?.creditTransfered ?? 0) +
        (data?.tpoChar?.creditTransfered ?? 0);
    return total;
  }
}
