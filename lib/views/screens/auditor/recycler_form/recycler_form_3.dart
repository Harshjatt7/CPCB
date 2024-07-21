import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
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
  const AuditorRecyclerForm3(
      {super.key,
      this.isSummaryScreen = false,
      this.isRetreader = false,
      this.id});
  final bool? isSummaryScreen;
  final bool isRetreader;
  final String? id;

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
                  isSummaryScreen: false,
                  onNextOrSubmit: () {
                    Provider.of<CommonStepperViewModel>(context, listen: false)
                        .onNextButton(context, "Recycler");
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
                      context, AppRoutes.auditorRecyclerProcurementScreen,
                      arguments: viewModel.procurementData);
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
            isDisable: true,
            isSummaryScreen: true,
            title: stringConstants.noOfSuppliersContacted,
            groupValue: viewModel.radioAContact,
            textEditingController: viewModel.aContactController,
            remakrsController: viewModel.aContactRemarksController,
          ),
          commonRecyclerForm3Tile(
            title: stringConstants.noOfSuppliersDetailsVerified,
            isDisable: true,
            isSummaryScreen: true,
            notVerifiedTitle: stringConstants.noOfSupplierSDetailsNotVerified,
            groupValue: viewModel.radioAVerified,
            textEditingController: viewModel.aVerifiedController,
            remakrsController: viewModel.aVerifiedRemakrsController,
            disableController: viewModel.aNotVerifiedController,
          ),
          CommonTitleWidget(label: stringConstants.physicallyVisit),
          commonRecyclerForm3Tile(
            isDisable: true,
            isSummaryScreen: true,
            title: stringConstants.noOfSuppliersContacted,
            groupValue: viewModel.radioBContact,
            textEditingController: viewModel.bContactController,
            remakrsController: viewModel.bContactRemarksController,
          ),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersDetailsVerified,
              isDisable: true,
              isSummaryScreen: true,
              groupValue: viewModel.radioBVerified,
              textEditingController: viewModel.bVerifiedController,
              disableController: viewModel.bNotVerifiedController,
              remakrsController: viewModel.bVerifiedRemakrsController,
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
              CommonTitleWidget(
                  label: stringConstants.verificationOfProcurement),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.auditorRecyclerProcurementScreen,
                      arguments: viewModel.procurementData);
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
              groupValue: viewModel.radioAContact,
              textEditingController: viewModel.aContactController,
              remakrsController: viewModel.aContactRemarksController,
              onChanged: (value) {
                viewModel.radioAContact = value ?? '';
                viewModel.updateUI();
              },
              remarkValidator: (value) {
                return viewModel
                    .emptyValidation(viewModel.aContactRemarksController);
              },
              validator: (value) {
                return viewModel.emptyValidation(viewModel.aContactController);
              }),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersDetailsVerified,
              isDisable: true,
              notVerifiedTitle: stringConstants.noOfSupplierSDetailsNotVerified,
              groupValue: viewModel.radioAVerified,
              textEditingController: viewModel.aVerifiedController,
              remakrsController: viewModel.aVerifiedRemakrsController,
              disableController: viewModel.aNotVerifiedController,
              onChanged: (value) {
                viewModel.radioAVerified = value ?? "";
                viewModel.updateUI();
              },
              remarkValidator: (value) {
                return viewModel.emptyValidation(viewModel.aVerifiedController);
              },
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.aVerifiedRemakrsController);
              }),
          CommonTitleWidget(label: stringConstants.physicallyVisit),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersContacted,
              groupValue: viewModel.radioBContact,
              textEditingController: viewModel.bContactController,
              remakrsController: viewModel.bContactRemarksController,
              onChanged: (value) {
                viewModel.radioBContact = value ?? '';
                viewModel.updateUI();
              },
              remarkValidator: (value) {
                return viewModel
                    .emptyValidation(viewModel.bContactRemarksController);
              },
              validator: (value) {
                return viewModel.emptyValidation(viewModel.bContactController);
              }),
          commonRecyclerForm3Tile(
              title: stringConstants.noOfSuppliersDetailsVerified,
              isDisable: true,
              groupValue: viewModel.radioBVerified,
              textEditingController: viewModel.bVerifiedController,
              disableController: viewModel.bNotVerifiedController,
              remakrsController: viewModel.bVerifiedRemakrsController,
              onChanged: (value) {
                viewModel.radioBVerified = value ?? '';
                viewModel.updateUI();
              },
              remarkValidator: (value) {
                return viewModel
                    .emptyValidation(viewModel.bVerifiedRemakrsController);
              },
              validator: (value) {
                return viewModel.emptyValidation(viewModel.bVerifiedController);
              },
              notVerifiedTitle: stringConstants.noOfSupplierSDetailsNotVerified)
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
      bool? isSummaryScreen = false}) {
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
          child: CommonTextFormFieldWidget(
              useLocalization: true,
              bgColor: appColor.white,
              hintText: title ?? "",
              isReadOnly: isSummaryScreen,
              isMandatory: false,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType: TextInputType.number,
              validator: validator,
              controller: textEditingController ?? TextEditingController()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(),
          child: CommonTextFormFieldWidget(
              bgColor: appColor.white,
              isReadOnly: isSummaryScreen,
              hintText: stringConstants.remarks.i18n(),
              isMandatory: false,
              validator: remarkValidator,
              controller: remakrsController ?? TextEditingController()),
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
}
