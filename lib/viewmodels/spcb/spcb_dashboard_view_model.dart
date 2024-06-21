import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/spcb/spcb_repository.dart';
import 'package:cpcb_tyre/models/request/spcb/spcb_complaint_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class SpcbDashboardViewModel extends BaseViewModel {
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController queryController = TextEditingController();
  final _spcbRepo = SpcbRepository();
  int page = 1;
  String? complaintError;

  Future raiseComplaint(
    BuildContext context,
    String? query,
  ) async {
    state = ViewState.busy;
    SpcbComplaintRequestModel request =
        SpcbComplaintRequestModel(complaint: query, userId: 3);
    try {
      APIResponse<AddDataResponseModel>? res = await _spcbRepo.postComplaint(
        request,
      );
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.completeResponse['message'] ?? "");
        }
      } else {
        final apiError = res?.error?.errorsList;
        complaintError = (apiError?.complaint ?? []).isEmpty
            ? ""
            : apiError?.complaint?.first ?? "";
        if (context.mounted) {
          HelperFunctions()
              .commonSuccessSnackBar(context, complaintError ?? "");
        }
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, StringConstants().somethingWentWrong);
      }
    }
    state = ViewState.idle;
    queryController.clear();
    updateUI();
  }
}
