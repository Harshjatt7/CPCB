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
  @override
  void initState() {
    viewModel = Provider.of<ProducerFormsViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProducerFormsViewModel>(
      builder: (context, viewModel, child) {
        return Stack(children: [
          Opacity(
            opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      widget.isSummaryScreen == true
                          ? CommonSingleChildScrollView(
                              child: viewReportView(context, viewModel))
                          : CommonSingleChildScrollView(
                              child: fillFormView(context, viewModel)),
                      Positioned(
                          bottom: 0,
                          left: 10,
                          right: 10,
                          child: StepperButton(
                            isLastStep: false,
                            isSummaryScreen: false,
                            onNextOrSubmit: () async {
                              await viewModel.postForm3Data(context,
                                  id: widget.id);
                            },
                            onSavedDraft: () async {
                              await viewModel.postForm3Data(context,
                                  id: widget.id, saveAsDraft: "SaveAsDraft");
                            },
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            controller: viewModel.deviationController,
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
            controller: viewModel.remarkController,
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
            controller: viewModel.summaryController,
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
            controller: viewModel.deviationController,
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
            controller: viewModel.remarkController,
            validator: (value) {
              return viewModel.validate(viewModel.remarkController.text);
            },
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
            controller: viewModel.summaryController,
            validator: (value) {
              return viewModel.validate(viewModel.summaryController.text);
            },
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
