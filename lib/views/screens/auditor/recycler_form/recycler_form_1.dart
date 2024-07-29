import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/widgets/app_components/auditor_form_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_auditor_recycler_form1_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_rich_text.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/plant_machinery_widget.dart';
import 'package:cpcb_tyre/views/widgets/app_components/recycler_data_table.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/forms/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AuditorRecyclerForm1 extends StatefulWidget {
  final bool? isSummaryScreen;
  final bool isRetreader;
  final String? id;
  final String? userType;

  const AuditorRecyclerForm1(
      {super.key,
      this.isSummaryScreen = false,
      this.isRetreader = false,
      this.id,
      this.userType});

  @override
  State<AuditorRecyclerForm1> createState() => _AuditorRecyclerForm1State();
}

class _AuditorRecyclerForm1State extends State<AuditorRecyclerForm1> {
  final AppColor appColor = AppColor();
  final stringConstants = StringConstants();
  ScrollController? controller;
  late RecyclerFormViewModel viewModel;
  @override
  void initState() {
    viewModel = Provider.of<RecyclerFormViewModel>(context, listen: false);
    viewModel.initializeForm1TextEditingControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecyclerFormViewModel>(
      builder: (context, value, child) {
        return Stack(
          children: [
            Opacity(
              opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
              child: widget.isSummaryScreen == true
                  ? CommonSingleChildScrollView(
                      child: summaryForm1View(viewModel, context))
                  : CommonSingleChildScrollView(
                      child: form1View(viewModel, context)),
            ),
            if (viewModel.state == ViewState.busy)
              Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(
                    color: appColor.black,
                  ),
                ),
              ),
            Positioned(
                bottom: 0,
                left: 10,
                right: 10,
                child: StepperButton(
                  isLastStep: false,
                  isSummaryScreen: widget.isSummaryScreen,
                  onNextOrSubmit: () async {
                    widget.isSummaryScreen == true
                        ? viewModel.onNextButton(
                            context, widget.id ?? "", widget.isRetreader)
                        : await viewModel.postForm1Data(context,
                            userId: widget.id ?? "",
                            isRetreader: widget.userType == "Retreader");
                  },
                  onSavedDraft: () async {
                    await viewModel.postForm1Data(context,
                        userId: widget.id ?? "",
                        isRetreader: widget.userType == "Retreader",
                        submit: "SaveAsDraft");
                  },
                ))
          ],
        );
      },
    );
  }

  Widget summaryForm1View(
      RecyclerFormViewModel viewModel, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.companyDetails),
          ),
          AuditorFormTile(
            groupValue: viewModel.radioGst,
            title: stringConstants.gst.i18n(),
            disableController: viewModel.gstController,
            remarkController: viewModel.gstRemarkController,
            isReadOnly: true,
          ),
          AuditorFormTile(
            isReadOnly: true,
            groupValue: viewModel.radioPanOfCompany,
            title: stringConstants.companyPanNo.i18n(),
            disableController: viewModel.companyPanController,
            remarkController: viewModel.companyPanRemarkController,
          ),
          AuditorFormTile(
            isReadOnly: true,
            groupValue: viewModel.radioIec,
            title: stringConstants.companyIec.i18n(),
            disableController: viewModel.companyIECController,
            remarkController: viewModel.companyRemarkIECController,
          ),
          AuditorFormTile(
            isReadOnly: true,
            groupValue: viewModel.radioCto,
            title: stringConstants.recyclerCto.i18n(),
            remarkController: viewModel.recyclerRemakrCTOController,
            disableController: viewModel.recyclerCTOController,
          ),
          AuditorFormTile(
            isReadOnly: true,
            groupValue: viewModel.radioAuthorization,
            title: stringConstants.authorizationUnder.i18n(),
            remarkController: viewModel.remarkAuthorizationController,
            disableController: viewModel.authorizationController,
          ),
          AuditorFormTile(
            isReadOnly: true,
            groupValue: viewModel.radioRecyclingDetails,
            title: stringConstants.recyclingFacilityDetails.i18n(),
            disableController: viewModel.recyclingDetailsController,
            remarkController: viewModel.remarkRecyclingDetailsController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonTextWidget(
                    stringConstants.gpsRecycler,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: appColor.black30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonTextFormFieldWidget(
                      disabledBgColor: appColor.black10,
                      isReadOnly: true,
                      hintText: stringConstants.gpsLatitude,
                      isMandatory: false,
                      controller: viewModel.gpsRecyclerLatitude ??
                          TextEditingController()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonTextFormFieldWidget(
                      disabledBgColor: appColor.black10,
                      isReadOnly: true,
                      hintText: stringConstants.gpsLongitude,
                      isMandatory: false,
                      controller: viewModel.gpsRecyclerLongitude ??
                          TextEditingController()),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonRadioButton(
                isMandatory: false,
                title: stringConstants.gpsAuditor.i18n(),
                groupValue: viewModel.radioGps,
                value1: stringConstants.radioValue1,
                value2: stringConstants.radioValue2,
                label1: stringConstants.notConfirmed,
                label2: stringConstants.confirmed,
                onChanged: null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: stringConstants.gpsLatitude,
                    isMandatory: false,
                    isReadOnly: true,
                    controller: viewModel.gpsAuditorLatitude ??
                        TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: stringConstants.gpsLongitude,
                    isMandatory: false,
                    isReadOnly: true,
                    controller: viewModel.gpsAuditorLongitude ??
                        TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: CommonTextWidget(
                  stringConstants.remark,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: appColor.black30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: stringConstants.remarks.i18n(),
                    maxLength: 100,
                    isMandatory: false,
                    isReadOnly: true,
                    controller: viewModel.gpsAuditorRemarkController ??
                        TextEditingController()),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.authorizedPerson),
          ),
          AuditorFormTile(
            isMandatory: false,
            groupValue: viewModel.radioAadharCard,
            title: stringConstants.authorizedAadharCard.i18n(),
            isUpload: true,
            uploadController: viewModel.uploadAadharController,
            remarkController: viewModel.remarkAadharController,
            disableController: viewModel.aadharController,
            isReadOnly: true,
            filePath: viewModel.aadharFilePath,
            isSummaryScreen: widget.isSummaryScreen,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AuditorFormTile(
              isMandatory: false,
              groupValue: viewModel.radioPanNo,
              title: stringConstants.authorizedPanNo.i18n(),
              isUpload: true,
              isReadOnly: true,
              isSummaryScreen: widget.isSummaryScreen,
              disableController: viewModel.panNoController,
              remarkController: viewModel.remarkPanNoController,
              uploadController: viewModel.uploadPanNoController,
              filePath: viewModel.panNoFilePath,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTitleWidget(
                    label: stringConstants.plantMachineryTitle),
              ),
              CommonRichText(
                title: stringConstants.plantMachinery.i18n(),
                isMandatory: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RecyclerDataTable(
                  isSummary: widget.isSummaryScreen,
                  machineControllerList: viewModel.plantMachineryControllerList,
                  radioList: viewModel.plantMachineyRadioList,
                  nwList: viewModel.nw ?? [],
                  headingList: viewModel.recyclerHeadingList,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: PlantMachineryWidget(
                  controllerList: viewModel.controllerList,
                  uploadControllerList: viewModel.uploadControllerList,
                  count: viewModel.count,
                  isDocument: true,
                  isReadOnly: true,
                  isSummaryScreen: widget.isSummaryScreen,
                  onTap: (index) {
                    viewModel.handleOnMachineTap(
                        context, viewModel.uploadControllerList[index], index);
                  },
                  onSuffixTap: (index) async {
                    await viewModel.handleOnMachineSuffixTap(
                        context, viewModel.uploadControllerList[index], index);
                  },
                  uploadValidator: (value) {
                    if (viewModel.machineFileSizeModel.isNotEmpty) {
                      int i = 0;
                      if (viewModel.uploadControllerList.length - 2 > 0) {
                        i = viewModel.uploadControllerList.length - 2;
                      }
                      return viewModel
                          .uploadValidation(viewModel.machineFileSizeModel[i]);
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.powerConsumption),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonRadioButton(
                      isMandatory: false,
                      groupValue: viewModel.radioPowerConsumption,
                      value1: stringConstants.radioValue1,
                      value2: stringConstants.radioValue2,
                      label1: stringConstants.notConfirmed,
                      label2: stringConstants.confirmed,
                      onChanged: null),
                  CommonRichText(
                      title: stringConstants.electricityBill.i18n(),
                      isMandatory: false),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                        isDocument: true,
                        hintText: stringConstants.uploadFile,
                        isMandatory: false,
                        isReadOnly: true,
                        controller: viewModel.uploadPowerController ??
                            TextEditingController()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                      isMandatory: false,
                      isReadOnly: true,
                      hintText: stringConstants.remarks.i18n(),
                      maxLength: 100,
                      controller: viewModel.remarkPowerController ??
                          TextEditingController(),
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.airPollution),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonAuditorRecyclerForm1Tile(
              isMandatory: false,
              isSummary: widget.isSummaryScreen,
              groupValue: viewModel.radioPollution,
              title: stringConstants.detailsOfPollution.i18n(),
              isUpload: true,
              isReadOnly: true,
              viewModel: viewModel,
              disableController: viewModel.pollutionController,
              remarksController: viewModel.remakrsPollutionController ??
                  TextEditingController(),
              uploadController: viewModel.uploadPollutionController,
              isDocument: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.videoOfPlant),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonRadioButton(
                      groupValue: viewModel.radioPlant,
                      value1: stringConstants.radioValue1,
                      value2: stringConstants.radioValue2,
                      label1: stringConstants.notConfirmed,
                      label2: stringConstants.confirmed,
                      onChanged: null),
                  CommonRichText(
                      title: stringConstants.anyOtherPlant.i18n(),
                      isMandatory: false),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                      isDocument: true,
                      isReadOnly: true,
                      hintText: stringConstants.uploadVideo,
                      isMandatory: false,
                      controller: viewModel.uploadVideoController ??
                          TextEditingController(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                      isMandatory: false,
                      hintText: stringConstants.remarks.i18n(),
                      maxLength: 100,
                      controller: viewModel.remarkVideoController ??
                          TextEditingController(),
                      isReadOnly: true,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget form1View(RecyclerFormViewModel viewModel, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.companyDetails),
          ),
          AuditorFormTile(
            isMandatory: true,
            groupValue: viewModel.radioGst,
            title: stringConstants.gst.i18n(),
            disableController: viewModel.gstController,
            remarkController: viewModel.gstRemarkController,
            onChanged: (value) {
              viewModel.radioGst = value ?? '';
              HelperFunctions().logger(viewModel.radioGst);
              viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel.emptyValidation(viewModel.gstRemarkController);
            // },
          ),
          if (viewModel.gstNoAuditRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.gstNoAuditRemarkError),
          AuditorFormTile(
            isMandatory: true,
            groupValue: viewModel.radioPanOfCompany,
            title: stringConstants.companyPanNo.i18n(),
            disableController: viewModel.companyPanController,
            remarkController: viewModel.companyPanRemarkController,
            onChanged: (value) {
              viewModel.radioPanOfCompany = value ?? '';
              viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel.emptyValidation(viewModel.companyPanController);
            // },
          ),
          if (viewModel.companyPanAuditRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.companyPanAuditRemarkError),
          AuditorFormTile(
            isMandatory: false,
            groupValue: viewModel.radioIec,
            title: stringConstants.companyIec.i18n(),
            disableController: viewModel.companyIECController,
            remarkController: viewModel.companyRemarkIECController,
            onChanged: (value) {
              viewModel.radioIec = value ?? "";
              viewModel.updateUI();
            },
          ),
          AuditorFormTile(
            isMandatory: true,
            groupValue: viewModel.radioCto,
            title: stringConstants.recyclerCto.i18n(),
            remarkController: viewModel.recyclerRemakrCTOController,
            disableController: viewModel.recyclerCTOController,
            onChanged: (value) {
              viewModel.radioCto = value ?? "";
              viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel
            //       .emptyValidation(viewModel.recyclerRemakrCTOController);
            // },
          ),
          if (viewModel.ctoAuditRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.ctoAuditRemarkError),
          AuditorFormTile(
            isMandatory: true,
            groupValue: viewModel.radioAuthorization,
            title: stringConstants.authorizationUnder.i18n(),
            remarkController: viewModel.remarkAuthorizationController,
            disableController: viewModel.authorizationController,
            onChanged: (value) {
              viewModel.radioAuthorization = value ?? "";
              viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel
            //       .emptyValidation(viewModel.remarkAuthorizationController);
            // },
          ),
          if (viewModel.authorizationUnderHomwRulesAuditRemarkError.isNotEmpty)
            showErrorMessage(
                context, viewModel.authorizationUnderHomwRulesAuditRemarkError),
          AuditorFormTile(
            isMandatory: true,
            groupValue: viewModel.radioRecyclingDetails,
            title: stringConstants.recyclingFacilityDetails.i18n(),
            disableController: viewModel.recyclingDetailsController,
            remarkController: viewModel.remarkRecyclingDetailsController,
            onChanged: (value) {
              viewModel.radioRecyclingDetails = value ?? "";
              viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel
            //       .emptyValidation(viewModel.remarkRecyclingDetailsController);
            // },
          ),
          if (viewModel.addressLine1AuditRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.addressLine1AuditRemarkError),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonTextWidget(
                    stringConstants.gpsRecycler,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: appColor.black30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonTextFormFieldWidget(
                      disabledBgColor: appColor.black10,
                      isReadOnly: true,
                      hintText: stringConstants.gpsLatitude,
                      isMandatory: false,
                      controller: viewModel.gpsRecyclerLatitude ??
                          TextEditingController()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonTextFormFieldWidget(
                      disabledBgColor: appColor.black10,
                      isReadOnly: true,
                      hintText: stringConstants.gpsLongitude,
                      isMandatory: false,
                      controller: viewModel.gpsRecyclerLongitude ??
                          TextEditingController()),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonRadioButton(
                  isMandatory: true,
                  title: stringConstants.gpsAuditor.i18n(),
                  groupValue: viewModel.radioGps,
                  value1: stringConstants.radioValue1,
                  value2: stringConstants.radioValue2,
                  label1: stringConstants.notConfirmed,
                  label2: stringConstants.confirmed,
                  onChanged: (value) {
                    viewModel.radioGps = value ?? '';
                    viewModel.updateUI();
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: stringConstants.gpsLatitude,
                    isMandatory: false,
                    // validator: (value) {
                    //   return viewModel
                    //       .emptyValidation(viewModel.gpsAuditorLatitude);
                    // },
                    controller: viewModel.gpsAuditorLatitude ??
                        TextEditingController()),
              ),
              if (viewModel.gpsLocationAuditorAdditionalDataLatError.isNotEmpty)
                showErrorMessage(context,
                    viewModel.gpsLocationAuditorAdditionalDataLatError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: stringConstants.gpsLongitude,
                    isMandatory: false,
                    // validator: (value) {
                    //   return viewModel
                    //       .emptyValidation(viewModel.gpsAuditorLongitude);
                    // },
                    controller: viewModel.gpsAuditorLongitude ??
                        TextEditingController()),
              ),
              if (viewModel
                  .gpsLocationAuditorAdditionalDataLongError.isNotEmpty)
                showErrorMessage(context,
                    viewModel.gpsLocationAuditorAdditionalDataLongError),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: CommonTextWidget(
                  stringConstants.remark,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: appColor.black30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: stringConstants.remarks.i18n(),
                    maxLength: 100,
                    isMandatory: false,
                    // validator: (value) {
                    //   return viewModel.emptyValidation(
                    //       viewModel.gpsAuditorRemarkController);
                    // },
                    controller: viewModel.gpsAuditorRemarkController ??
                        TextEditingController()),
              ),
              if (viewModel.gpsLocationAuditorAuditRemarkError.isNotEmpty)
                showErrorMessage(
                    context, viewModel.gpsLocationAuditorAuditRemarkError),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.authorizedPerson),
          ),
          AuditorFormTile(
            isMandatory: false,
            groupValue: viewModel.radioAadharCard,
            title: stringConstants.authorizedAadharCard.i18n(),
            isUpload: true,
            uploadController: viewModel.uploadAadharController,
            remarkController: viewModel.remarkAadharController,
            disableController: viewModel.aadharController,
            onChanged: (value) {
              viewModel.radioAadharCard = value ?? "";
              viewModel.updateUI();
            },
            filePath: viewModel.aadharFilePath,
            onTap: () {
              viewModel.handleOnTap(context, RecyclerForm1.aadhar,
                  viewModel.uploadAadharController);
            },
            onSuffixTap: () {
              viewModel.handleOnSuffixTap(
                context,
                RecyclerForm1.aadhar,
                viewModel.uploadAadharController,
              );
            },
            uploadValidator: (value) {
              return viewModel.uploadValidation(viewModel.aadharFileSizeModel);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AuditorFormTile(
                isMandatory: false,
                groupValue: viewModel.radioPanNo,
                title: stringConstants.authorizedPanNo.i18n(),
                isUpload: true,
                disableController: viewModel.panNoController,
                remarkController: viewModel.remarkPanNoController,
                uploadController: viewModel.uploadPanNoController,
                onChanged: (value) {
                  viewModel.radioPanNo = value ?? "";
                  viewModel.updateUI();
                },
                filePath: viewModel.panNoFilePath,
                onTap: () {
                  viewModel.handleOnTap(context, RecyclerForm1.panNo,
                      viewModel.uploadPanNoController);
                },
                onSuffixTap: () {
                  viewModel.handleOnSuffixTap(
                    context,
                    RecyclerForm1.panNo,
                    viewModel.uploadPanNoController,
                  );
                },
                uploadValidator: (value) {
                  return viewModel
                      .uploadValidation(viewModel.panNoFileSizeModel);
                }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTitleWidget(
                    label: stringConstants.plantMachineryTitle),
              ),
              CommonRichText(
                  title: stringConstants.plantMachinery.i18n(),
                  isMandatory: true),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RecyclerDataTable(
                  isSummary: widget.isSummaryScreen,
                  machineControllerList: viewModel.plantMachineryControllerList,
                  radioList: viewModel.plantMachineyRadioList,
                  nwList: viewModel.nw ?? [],
                  headingList: viewModel.recyclerHeadingList,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: PlantMachineryWidget(
                  controllerList: viewModel.controllerList,
                  uploadControllerList: viewModel.uploadControllerList,
                  count: viewModel.count,
                  isDocument: true,
                  onTap: (index) {
                    viewModel.handleOnMachineTap(
                        context, viewModel.uploadControllerList[index], index);
                  },
                  onSuffixTap: (index) async {
                    await viewModel.handleOnMachineSuffixTap(
                        context, viewModel.uploadControllerList[index], index);
                  },
                  uploadValidator: (value) {
                    if (viewModel.machineFileSizeModel.isNotEmpty) {
                      int i = 0;
                      if (viewModel.uploadControllerList.length - 2 > 0) {
                        i = viewModel.uploadControllerList.length - 2;
                      }
                      return viewModel
                          .uploadValidation(viewModel.machineFileSizeModel[i]);
                    }
                    return null;
                  },
                  onAdd: () {
                    viewModel.onAdd();
                  },
                  onDelete: () {
                    viewModel.onDelete();
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.powerConsumption),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonRadioButton(
                      isMandatory: true,
                      groupValue: viewModel.radioPowerConsumption,
                      value1: stringConstants.radioValue1,
                      value2: stringConstants.radioValue2,
                      label1: stringConstants.notConfirmed,
                      label2: stringConstants.confirmed,
                      onChanged: (value) {
                        viewModel.radioPowerConsumption = value ?? '';
                        viewModel.updateUI();
                      }),
                  CommonRichText(
                      title: stringConstants.electricityBill.i18n(),
                      isMandatory: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                        icon: viewModel.uploadPowerController?.text.isEmpty ??
                                false
                            ? viewModel.imageConstants.fileUpload
                            : viewModel.imageConstants.removeIcon,
                        isDocument: true,
                        onTap: () {
                          viewModel.handleOnTap(
                            context,
                            RecyclerForm1.power,
                            viewModel.uploadPowerController,
                          );
                        },
                        onSuffixTap: () {
                          viewModel.handleOnSuffixTap(
                            context,
                            RecyclerForm1.power,
                            viewModel.uploadPowerController,
                          );
                        },
                        validator: (value) {
                          return viewModel
                              .uploadValidation(viewModel.powerFileSizeModel);
                        },
                        hintText: stringConstants.uploadFile,
                        isMandatory: false,
                        controller: viewModel.uploadPowerController ??
                            TextEditingController()),
                  ),
                  if (viewModel
                      .lastYearElectricityBillAuditDocumentError.isNotEmpty)
                    showErrorMessage(context,
                        viewModel.lastYearElectricityBillAuditDocumentError),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                      isMandatory: false,
                      hintText: stringConstants.remarks.i18n(),
                      maxLength: 100,
                      controller: viewModel.remarkPowerController ??
                          TextEditingController(),
                      validator: (value) {
                        return viewModel
                            .emptyValidation(viewModel.remarkPowerController);
                      },
                    ),
                  ),
                  if (viewModel
                      .lastYearElectricityBillAuditRemarkError.isNotEmpty)
                    showErrorMessage(context,
                        viewModel.lastYearElectricityBillAuditRemarkError),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.airPollution),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonAuditorRecyclerForm1Tile(
              isSummary: widget.isSummaryScreen,
              isMandatory: false,
              groupValue: viewModel.radioPollution,
              title: stringConstants.detailsOfPollution.i18n(),
              isUpload: true,
              viewModel: viewModel,
              disableController: viewModel.pollutionController,
              remarksController: viewModel.remakrsPollutionController ??
                  TextEditingController(),
              uploadController: viewModel.uploadPollutionController,
              onChanged: (value) {
                viewModel.radioPollution = value ?? "";
                viewModel.updateUI();
              },
              uploadValidator: (value) {
                return viewModel
                    .uploadValidation(viewModel.pollutionFileSizeModel);
              },
              isDocument: true,
              onTap: () {
                viewModel.handleOnTap(
                  context,
                  RecyclerForm1.pollution,
                  viewModel.uploadPollutionController,
                );
              },
              onSuffixTap: () {
                viewModel.handleOnSuffixTap(
                  context,
                  RecyclerForm1.pollution,
                  viewModel.uploadPollutionController,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTitleWidget(label: stringConstants.videoOfPlant),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonRadioButton(
                      groupValue: viewModel.radioPlant,
                      value1: stringConstants.radioValue1,
                      value2: stringConstants.radioValue2,
                      label1: stringConstants.notConfirmed,
                      label2: stringConstants.confirmed,
                      onChanged: (value) {
                        viewModel.radioPlant = value ?? '';
                        viewModel.updateUI();
                      }),
                  CommonRichText(
                      title: stringConstants.anyOtherPlant.i18n(),
                      isMandatory: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                        isDocument: true,
                        icon: viewModel.uploadVideoController?.text.isEmpty ??
                                false
                            ? viewModel.imageConstants.fileUpload
                            : viewModel.imageConstants.removeIcon,
                        onTap: () async {
                          viewModel.handleOnTap(context, RecyclerForm1.video,
                              viewModel.uploadVideoController,
                              isVideo: true);
                        },
                        onSuffixTap: () async {
                          viewModel.handleOnSuffixTap(
                              context,
                              RecyclerForm1.video,
                              viewModel.uploadVideoController,
                              isVideo: true);
                        },
                        // validator: (value) {
                        //   return viewModel.videoValidation();
                        // },
                        hintText: stringConstants.uploadVideo,
                        isMandatory: false,
                        controller: viewModel.uploadVideoController ??
                            TextEditingController()),
                  ),
                  if (viewModel
                      .geoTaggedVideoUploadAuditDocumentError.isNotEmpty)
                    showErrorMessage(context,
                        viewModel.geoTaggedVideoUploadAuditDocumentError),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonTextFormFieldWidget(
                      isMandatory: false,
                      hintText: stringConstants.remarks.i18n(),
                      maxLength: 100,
                      controller: viewModel.remarkVideoController ??
                          TextEditingController(),
                      // validator: (value) {
                      //   return viewModel
                      //       .emptyValidation(viewModel.remarkVideoController);
                      // },
                    ),
                  ),
                  if (viewModel.geoTaggedVideoUploadAuditRemarkError.isNotEmpty)
                    showErrorMessage(context,
                        viewModel.geoTaggedVideoUploadAuditRemarkError),
                ],
              )),
        ],
      ),
    );
  }

  Widget showErrorMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        child: CommonTextWidget(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: appColor.red),
        ),
      ),
    );
  }
}
