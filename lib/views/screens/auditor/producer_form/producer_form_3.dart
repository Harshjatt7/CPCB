import 'package:cpcb_tyre/constants/store_key_constants.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import '../../../../constants/enums/state_enums.dart';
import '../../../../viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import '../../../widgets/components/common_single_child_scrollview.dart';
import '../../../widgets/components/common_text_widget.dart';
import '../../../widgets/forms/stepper_button.dart';

// ignore: must_be_immutable
class ProducerForm3 extends StatefulWidget {
  final bool? isSummaryScreen;
  final String? id;
  const ProducerForm3({super.key, this.isSummaryScreen, this.id});

  @override
  State<ProducerForm3> createState() => _ProducerForm3State();
}

class _ProducerForm3State extends State<ProducerForm3> {
  late ProducerFormsViewModel viewModel;
  final storeKeyConstants = StoreKeyConstants();

  @override
  void initState() {
    viewModel = Provider.of<ProducerFormsViewModel>(context, listen: false);
    viewModel.initializeForm2TextEditingControllers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProducerFormsViewModel>(
      builder: (context, viewModel, child) {
        return Stack(children: [
          Opacity(
            opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
            child: widget.isSummaryScreen == true
                ? SizedBox(
                    height: Responsive().givenHeight * .8,
                    child: CommonSingleChildScrollView(
                        child: viewReportView(context, viewModel)),
                  )
                : SizedBox(
                    height: Responsive().givenHeight * .8,
                    child: CommonSingleChildScrollView(
                        child: fillFormView(context, viewModel)),
                  ),
          ),
          Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: StepperButton(
                isLastStep: true,
                isSummaryScreen: widget.isSummaryScreen,
                onNextOrSubmit: () async {
                  widget.isSummaryScreen == true
                      ? viewModel.onNextButton(context, widget.id ?? "")
                      : await viewModel.postForm3Data(context, id: widget.id);
                },
                onSavedDraft: () async {
                  await viewModel.postForm3Data(context,
                      id: widget.id,
                      saveAsDraft: storeKeyConstants.saveAsDraft);
                },
              )),
          if (viewModel.state == ViewState.busy)
            Center(
              child: CircularProgressIndicator(
                color: viewModel.appColor.black,
              ),
            ),
        ]);
      },
    );
  }

  Padding viewReportView(
      BuildContext context, ProducerFormsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRadioButton(
            context,
            viewModel: viewModel,
            title: viewModel.stringConstants.misreporting,
            groupValue: viewModel.radioMisreporting,
          ),
          CommonTextFormFieldWidget(
            hintText: viewModel.stringConstants.deviation,
            isMandatory: false,
            controller:
                viewModel.deviationController ?? TextEditingController(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            isReadOnly: true,
            disabledBgColor: viewModel.appColor.black10,
          ),
          const SizedBox(
            height: 24,
          ),
          buildRadioButton(
            context,
            viewModel: viewModel,
            title: viewModel.stringConstants.falseInformation,
            groupValue: viewModel.radioInformation,
          ),
          CommonTextFormFieldWidget(
            isMultiline: true,
            hintText: viewModel.stringConstants.remarks.i18n(),
            isMandatory: true,
            controller: viewModel.remarkController ?? TextEditingController(),
            isReadOnly: true,
            maxLength: 100,
            maxLines: 3,
            disabledBgColor: viewModel.appColor.black10,
          ),
          const SizedBox(
            height: 16,
          ),
          CommonTextFormFieldWidget(
            isMultiline: true,
            hintText: viewModel.stringConstants.summary.i18n(),
            isMandatory: true,
            controller: viewModel.summaryController ?? TextEditingController(),
            isReadOnly: true,
            maxLength: 500,
            maxLines: 3,
            disabledBgColor: viewModel.appColor.black10,
          ),
        ],
      ),
    );
  }

  Padding fillFormView(BuildContext context, ProducerFormsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRadioButton(
            context,
            viewModel: viewModel,
            title: viewModel.stringConstants.misreporting,
            groupValue: viewModel.radioMisreporting,
            onChanged: (value) {
              viewModel.radioMisreporting = value ?? "";
              viewModel.updateUI();
            },
          ),
          CommonTextFormFieldWidget(
            hintText: viewModel.stringConstants.deviation,
            isMandatory: false,
            controller:
                viewModel.deviationController ?? TextEditingController(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(
            height: 24,
          ),
          buildRadioButton(
            context,
            viewModel: viewModel,
            title: viewModel.stringConstants.falseInformation,
            groupValue: viewModel.radioInformation,
            onChanged: (value) {
              viewModel.radioInformation = value ?? "";
              viewModel.updateUI();
            },
          ),
          CommonTextFormFieldWidget(
            isMultiline: true,
            hintText: viewModel.stringConstants.remarks.i18n(),
            isMandatory: true,
            controller: viewModel.remarkController ?? TextEditingController(),
            // validator: (value) {
            //   return viewModel.validate(viewModel.remarkController.text);
            // },
            maxLength: 100,
            maxLines: 3,
          ),
          if (viewModel.auditRemarkError?.isNotEmpty ?? false)
            showErrorMessage(context, viewModel.auditRemarkError ?? ""),
          const SizedBox(
            height: 16,
          ),
          CommonTextFormFieldWidget(
            isMultiline: true,
            hintText: viewModel.stringConstants.summary.i18n(),
            isMandatory: true,
            controller: viewModel.summaryController ?? TextEditingController(),
            // validator: (value) {
            //   return viewModel.validate(viewModel.summaryController.text);
            // },
            maxLength: 500,
            maxLines: 3,
          ),
          if (viewModel.summaryError?.isNotEmpty ?? false)
            showErrorMessage(context, viewModel.summaryError ?? ""),
        ],
      ),
    );
  }

  CommonRadioButton buildRadioButton(BuildContext context,
      {ProducerFormsViewModel? viewModel,
      String? title,
      String? groupValue,
      Function(String?)? onChanged}) {
    return CommonRadioButton(
      title: title?.i18n(),
      titleStyle: Theme.of(context).textTheme.labelSmall,
      groupValue: groupValue ?? "",
      value1: "1",
      value2: "0",
      label1: viewModel?.stringConstants.yes ?? "",
      label2: viewModel?.stringConstants.no ?? "",
      onChanged: onChanged,
      padding: const EdgeInsets.symmetric(vertical: 16),
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
              ?.copyWith(color: viewModel.appColor.red),
        ),
      ),
    );
  }
}
