import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/forms/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class AuditorRecyclerForm3 extends StatefulWidget {
  final bool? isSummaryScreen;
  final bool isRetreader;
  final String? id;
  final String? userType;
  const AuditorRecyclerForm3({
    super.key,
    this.isSummaryScreen = false,
    this.isRetreader = false,
    this.id,
    this.userType,
  });

  @override
  State<AuditorRecyclerForm3> createState() => _AuditorRecyclerForm3State();
}

class _AuditorRecyclerForm3State extends State<AuditorRecyclerForm3> {
  final AppColor appColor = AppColor();
  final StringConstants stringConstants = StringConstants();
  ScrollController? controller;
  late RecyclerFormViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<RecyclerFormViewModel>(context, listen: false);
    viewModel.initializeForm3TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) {
        return Stack(
          children: [
            Opacity(
              opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
              child: widget.isSummaryScreen == true
                  ? CommonSingleChildScrollView(
                      child: summaryForm3View(context, viewModel))
                  : CommonSingleChildScrollView(
                      child: form3View(context, viewModel)),
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
                        : await viewModel.recyclerPostForm3Data(context,
                            id: widget.id,
                            isRetreader: widget.userType == "Retreader");
                  },
                  onSavedDraft: () async {
                    await viewModel.recyclerPostForm3Data(context,
                        id: widget.id,
                        isRetreader: widget.userType == "Retreader",
                        saveAsDraft: "SaveAsDraft");
                  },
                ))
          ],
        );
      },
    );
  }

  Widget summaryForm3View(
      BuildContext context, RecyclerFormViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonTitleWidget(
                  label: stringConstants.verificationOfProcurement),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.auditorRecyclerProcurementScreen,
                    arguments: viewModel,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: CommonTextWidget(
                    useLocalization: true,
                    stringConstants.viewEntries,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: appColor.blue100,
                          decoration: TextDecoration.underline,
                          decorationColor: appColor.blue100,
                        ),
                  ),
                ),
              )
            ],
          ),
          commonRecyclerForm3Tile(
            isSummaryScreen: true,
            title: stringConstants.noOfSuppliersContacted,
            groupValue: viewModel.radioProcurementInfoContact,
            textEditingController: viewModel.procurementInfoContact,
            remakrsController: viewModel.procurementInfoContactRemarks,
          ),
          commonRecyclerForm3Tile(
            title: stringConstants.noOfSuppliersDetailsVerified,
            isDisable: true,
            isSummaryScreen: true,
            notVerifiedTitle: stringConstants.noOfSupplierSDetailsNotVerified,
            groupValue: viewModel.radioProcurementInfoVerified,
            textEditingController: viewModel.procurementInfoAuditVerified,
            remakrsController: viewModel.procurmentInfoVerifiedRemark,
            disableController: viewModel.aNotVerifiedController,
          ),
          CommonTitleWidget(label: stringConstants.physicallyVisit),
          commonRecyclerForm3Tile(
            isSummaryScreen: true,
            title: stringConstants.noOfSuppliersContacted,
            groupValue: viewModel.radioProcurementInfoPhysicallyContacted,
            textEditingController: viewModel.physicallyContactedValue,
            remakrsController: viewModel.physicallyContactedRemark,
          ),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersDetailsVerified,
              isDisable: true,
              isSummaryScreen: true,
              groupValue: viewModel.radioProcurementInfoPhysicallyVerified,
              textEditingController: viewModel.physicallyVerifiedValue,
              disableController: viewModel.bNotVerifiedController,
              remakrsController: viewModel.physicallyVerifiedRemark,
              notVerifiedTitle: stringConstants.noOfSupplierSDetailsNotVerified)
        ],
      ),
    );
  }

  Widget form3View(BuildContext context, RecyclerFormViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: CommonTitleWidget(
                    label: stringConstants.verificationOfProcurement),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.auditorRecyclerProcurementScreen,
                      arguments: viewModel);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: CommonTextWidget(
                    useLocalization: true,
                    stringConstants.viewEntries,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: appColor.blue100,
                        decoration: TextDecoration.underline,
                        decorationColor: appColor.blue100),
                  ),
                ),
              )
            ],
          ),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersContacted,
              groupValue: viewModel.radioProcurementInfoContact,
              textEditingController: viewModel.procurementInfoContact,
              remakrsController: viewModel.procurementInfoContactRemarks,
              onChanged: (value) {
                viewModel.radioProcurementInfoContact = value ?? '';
                viewModel.updateUI();
              },
              valueError: viewModel.contactedSuppliersError,
              remarkError: viewModel.contactedAuditRemarkError
              // remarkValidator: (value) {
              //   return viewModel
              //       .emptyValidation(viewModel.aContactRemarksController);
              // },
              // validator: (value) {
              //   return viewModel.emptyValidation(viewModel.aContactController);
              // }
              ),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersDetailsVerified,
              isDisable: true,
              notVerifiedTitle: stringConstants.noOfSupplierSDetailsNotVerified,
              groupValue: viewModel.radioProcurementInfoVerified,
              textEditingController: viewModel.procurementInfoAuditVerified,
              remakrsController: viewModel.procurmentInfoVerifiedRemark,
              disableController: viewModel.aNotVerifiedController,
              onChanged: (value) {
                viewModel.radioProcurementInfoVerified = value ?? "";
                viewModel.updateUI();
              },
              remarkError: viewModel.verifiedAuditRemarkError,
              valueError: viewModel.verifiedSuppliersError
              // remarkValidator: (value) {
              //   return viewModel.emptyValidation(viewModel.aVerifiedController);
              // },
              // validator: (value) {
              //   return viewModel
              //       .emptyValidation(viewModel.aVerifiedRemakrsController);
              // }
              ),
          CommonTitleWidget(label: stringConstants.physicallyVisit),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersContacted,
              groupValue: viewModel.radioProcurementInfoPhysicallyContacted,
              textEditingController: viewModel.physicallyContactedValue,
              remakrsController: viewModel.physicallyContactedRemark,
              onChanged: (value) {
                viewModel.radioProcurementInfoPhysicallyContacted = value ?? '';
                viewModel.updateUI();
              },
              valueError: viewModel.physicallyVerifiedSuppliersError,
              remarkError: viewModel.physicallyVerifiedAuditRemarkError
              // remarkValidator: (value) {
              //   return viewModel
              //       .emptyValidation(viewModel.bContactRemarksController);
              // },
              // validator: (value) {
              //   return viewModel.emptyValidation(viewModel.bContactController);
              // }
              ),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersDetailsVerified,
              isDisable: true,
              groupValue: viewModel.radioProcurementInfoPhysicallyVerified,
              textEditingController: viewModel.physicallyVerifiedValue,
              disableController: viewModel.bNotVerifiedController,
              remakrsController: viewModel.physicallyVerifiedRemark,
              onChanged: (value) {
                viewModel.radioProcurementInfoPhysicallyVerified = value ?? '';
                viewModel.updateUI();
              },
              remarkError: viewModel.physicallyContactedAuditRemarkError,
              valueError: viewModel.physicallyContactedSuppliersError,

              // remarkValidator: (value) {
              //   return viewModel
              //       .emptyValidation(viewModel.bVerifiedRemakrsController);
              // },
              // validator: (value) {
              //   return viewModel.emptyValidation(viewModel.bVerifiedController);
              // },
              notVerifiedTitle:
                  stringConstants.noOfSupplierSDetailsNotVerified),
        ],
      ),
    );
  }

  Column commonRecyclerForm3Tile(
      {String? title,
      String? notVerifiedTitle,
      TextEditingController? textEditingController,
      TextEditingController? remakrsController,
      TextEditingController? disableController,
      void Function(String?)? onChanged,
      String? Function(String?)? validator,
      String? Function(String?)? remarkValidator,
      RecyclerFormViewModel? viewModel,
      String? groupValue,
      bool isDisable = false,
      bool? isSummaryScreen = false,
      String? valueError,
      String? remarkError}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CommonMandatoryTitle(
            title: title ?? '',
            isMandatory: true,
          ),
        ),
        CommonRadioButton(
            isMandatory: false,
            groupValue: groupValue ?? '',
            value1: stringConstants.radioValue1,
            value2: stringConstants.radioValue2,
            label1: stringConstants.notConfirmed,
            label2: stringConstants.confirmed,
            onChanged: onChanged),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          child: Column(
            children: [
              CommonTextFormFieldWidget(
                  useLocalization: true,
                  bgColor: appColor.white,
                  hintText: title ?? "",
                  isReadOnly: isSummaryScreen,
                  isMandatory: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputType: TextInputType.number,
                  validator: validator,
                  controller: textEditingController ?? TextEditingController()),
              if (valueError?.isNotEmpty ?? false)
                showErrorMessage(context, valueError ?? ""),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            children: [
              CommonTextFormFieldWidget(
                bgColor: appColor.white,
                isReadOnly: isSummaryScreen,
                hintText: stringConstants.remarks.i18n(),
                isMandatory: false,
                validator: remarkValidator,
                controller: remakrsController ?? TextEditingController(),
              ),
              if (remarkError?.isNotEmpty ?? false)
                showErrorMessage(context, remarkError ?? ""),
            ],
          ),
        ),
        if (isDisable == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CommonTextFormFieldWidget(
                useLocalization: true,
                disabledBgColor: appColor.black10,
                bgColor: appColor.white,
                isReadOnly: isDisable,
                hintText: notVerifiedTitle ?? "",
                isMandatory: false,
                controller: disableController ?? TextEditingController()),
          ),
      ],
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
