import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/auditor_form_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_multiline_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/plant_machinery_widget.dart';
import 'package:cpcb_tyre/views/widgets/app_components/recycler_data_table.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

// ignore: must_be_immutable
class AuditorRecyclerForm1 extends StatelessWidget {
  AuditorRecyclerForm1({super.key});
  final AppColor appColor = AppColor();
  final stringConstants = StringConstants();

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm1ViewModel>(
        onModelReady: (viewModel) async {
          viewModel.initalizeGroupValues();
          viewModel.addController();
          viewModel.getCurrentLocation();
        },
        viewModel: RecyclerForm1ViewModel(),
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child:
                      CommonTitleWidget(label: stringConstants.companyDetails),
                ),
                AuditorFormTile(
                  isMandatory: true,
                  groupValue: viewModel.radioGst,
                  title: stringConstants.gst.i18n(),
                  disableController: viewModel.gstController,
                  remarkController: viewModel.gstRemarkController,
                  onChanged: (value) {
                    viewModel.radioGst = value ?? '';
                    viewModel.updateUI();
                  },
                ),
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
                ),
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
                ),
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
                ),
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
                            controller: viewModel.gpsRecyclerLatitude),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            disabledBgColor: appColor.black10,
                            isReadOnly: true,
                            hintText: stringConstants.gpsLongitude,
                            isMandatory: false,
                            controller: viewModel.gpsAuditorLongitude),
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
                        value1: stringConstants.notConfirmed,
                        value2: stringConstants.confirmed,
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
                          controller: viewModel.gpsAuditorLatitude),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CommonTextFormFieldWidget(
                          hintText: stringConstants.gpsLongitude,
                          isMandatory: false,
                          controller: viewModel.gpsAuditorLongitude),
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
                      child: CommonMultilineTextFormField(
                          label: stringConstants.remarks.i18n(),
                          maxLength: 500,
                          isMandatory: false,
                          controller: viewModel.gpsAuditorRemarkController),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonTitleWidget(
                      label: stringConstants.authorizedPerson),
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
                        viewModel.uploadAadharController, viewModel.aadharFile);
                  },
                  onSuffixTap: () {
                    viewModel.handleOnSuffixTap(context, RecyclerForm1.aadhar,
                        viewModel.uploadAadharController, viewModel.aadharFile);
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
                          viewModel.uploadPanNoController, viewModel.panNoFile);
                    },
                    onSuffixTap: () {
                      viewModel.handleOnSuffixTap(context, RecyclerForm1.panNo,
                          viewModel.uploadPanNoController, viewModel.panNoFile);
                    },
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
                    commonRichText(
                        stringConstants.plantMachinery.i18n(), context, true),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: RecyclerDataTable(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: PlantMachineryWidget(
                        controllerList: viewModel.controllerList,
                        uploadControllerList: viewModel.uploadControllerList,
                        count: viewModel.count,
                        isDocument: true,
                      
                        onTap: () {
                          viewModel.handleOnTap(
                              context,
                              RecyclerForm1.machine,
                              viewModel
                                  .uploadControllerList[viewModel.count - 1],
                              viewModel.machineFile);
                        },
                        onSuffixTap: () {
                          viewModel.handleOnSuffixTap(
                              context,
                              RecyclerForm1.machine,
                              viewModel
                                  .uploadControllerList[viewModel.count - 1],
                              viewModel.machineFile);
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
                  child: CommonTitleWidget(
                      label: stringConstants.powerConsumption),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonRadioButton(
                            isMandatory: true,
                            groupValue: viewModel.radioPowerConsumption,
                            value1: stringConstants.notConfirmed,
                            value2: stringConstants.confirmed,
                            label1: stringConstants.notConfirmed,
                            label2: stringConstants.confirmed,
                            onChanged: (value) {
                              viewModel.radioPowerConsumption = value ?? '';
                              viewModel.updateUI();
                            }),
                        commonRichText(stringConstants.electricityBill.i18n(),
                            context, true),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              icon: viewModel.uploadPowerController.text.isEmpty
                                  ? viewModel.imageConstants.fileUpload
                                  : viewModel.imageConstants.removeIcon,
                              isDocument: viewModel.powerFilePath == null
                                  ? false
                                  : true,
                              onTap: () {
                                viewModel.handleOnTap(
                                    context,
                                    RecyclerForm1.power,
                                    viewModel.uploadPowerController,
                                    viewModel.powerFile);
                              },
                              onSuffixTap: () {
                                viewModel.handleOnSuffixTap(
                                    context,
                                    RecyclerForm1.power,
                                    viewModel.uploadPowerController,
                                    viewModel.powerFile);
                              },
                              hintText: stringConstants.uploadFile,
                              isMandatory: false,
                              controller: viewModel.uploadPowerController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonMultilineTextFormField(
                            label: stringConstants.remarks.i18n(),
                            maxLength: 500,
                            controller: viewModel.remarkPowerController,
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
                  child: commonFormTiles(
                    context,
                    isMandatory: false,
                    groupValue: viewModel.radioPollution,
                    title: stringConstants.detailsOfPollution.i18n(),
                    isUpload: true,
                    viewModel: viewModel,
                    disableController: viewModel.pollutionController,
                    remarksController: viewModel.remakrsPollutionController,
                    uploadController: viewModel.uploadPollutionController,
                    onChanged: (value) {
                      viewModel.radioPollution = value ?? "";
                      viewModel.updateUI();
                    },
                    isDocument:
                        viewModel.pollutionFilePath == null ? false : true,
                    onTap: () {
                      viewModel.handleOnTap(
                          context,
                          RecyclerForm1.pollution,
                          viewModel.uploadPollutionController,
                          viewModel.pollutionFile);
                    },
                    onSuffixTap: () {
                      viewModel.handleOnSuffixTap(
                          context,
                          RecyclerForm1.aadhar,
                          viewModel.uploadPollutionController,
                          viewModel.pollutionFile);
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
                            value1: stringConstants.notConfirmed,
                            value2: stringConstants.confirmed,
                            label1: stringConstants.notConfirmed,
                            label2: stringConstants.confirmed,
                            onChanged: (value) {
                              viewModel.radioPlant = value ?? '';
                              viewModel.updateUI();
                            }),
                        commonRichText(stringConstants.anyOtherPlant.i18n(),
                            context, false),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              isDocument: viewModel.videoFilePath == null
                                  ? false
                                  : true,
                              icon: viewModel.uploadVideoController.text.isEmpty
                                  ? viewModel.imageConstants.fileUpload
                                  : viewModel.imageConstants.removeIcon,
                              onTap: () {
                                viewModel.handleOnTap(
                                    context,
                                    RecyclerForm1.video,
                                    viewModel.uploadVideoController,
                                    viewModel.videoFile);
                              },
                              onSuffixTap: () {
                                viewModel.handleOnSuffixTap(
                                    context,
                                    RecyclerForm1.video,
                                    viewModel.uploadVideoController,
                                    viewModel.videoFile);
                              },
                              hintText: stringConstants.uploadVideo,
                              isMandatory: false,
                              controller: viewModel.uploadVideoController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonMultilineTextFormField(
                            label: stringConstants.remarks.i18n(),
                            maxLength: 500,
                            controller: viewModel.remarkVideoController,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        });
  }

  Column commonFormTiles(BuildContext context,
      {bool isMandatory = false,
      String? groupValue,
      String? title,
      bool isUpload = false,
      bool isDisableField = true,
      RecyclerForm1ViewModel? viewModel,
      TextEditingController? disableController,
      TextEditingController? remarksController,
      TextEditingController? uploadController,
      bool isDocument = false,
      void Function()? onTap,
      void Function()? onSuffixTap,
      void Function(String?)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRadioButton(
            isMandatory: isMandatory,
            groupValue: groupValue ?? "",
            value1: stringConstants.notConfirmed,
            value2: stringConstants.confirmed,
            label1: stringConstants.notConfirmed,
            label2: stringConstants.confirmed,
            onChanged: onChanged),
        commonRichText(title, context, isMandatory),
        if (isDisableField == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                disabledBgColor: appColor.black10,
                isReadOnly: true,
                hintText: title ?? '',
                isMandatory: false,
                controller: disableController ?? TextEditingController()),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CommonMultilineTextFormField(
              bgColor: appColor.white,
              label: stringConstants.remarks.i18n(),
              isMandatory: false,
              controller: remarksController ?? TextEditingController()),
        ),
        if (isUpload == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
              disabledBgColor: appColor.transparent,
              isReadOnly: true,
              hintText: stringConstants.upload.i18n(),
              icon: uploadController?.text.isEmpty ?? false
                  ? viewModel?.imageConstants.fileUpload
                  : viewModel?.imageConstants.removeIcon,
              onTap: onTap,
              onSuffixTap: onSuffixTap,
              isDocument: isDocument,
              validator: (value) {
                return null;
                // return viewModel.uploadInvoiceValidation();
              },
              isMandatory: false,
              controller: uploadController ?? TextEditingController(),
            ),
          )
      ],
    );
  }

  Padding commonRichText(
      String? title, BuildContext context, bool isMandatory) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: appColor.black30),
          children: [
            TextSpan(
              text: isMandatory == true ? " *" : "",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: appColor.red),
            ),
          ],
        ),
      ),
    );
  }
}
