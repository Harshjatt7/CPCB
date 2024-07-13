import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';

import '../../../../viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import '../../../widgets/components/common_single_child_scrollview.dart';

class ProducerForm3 extends StatelessWidget {
  final bool? isSummaryScreen;
  const ProducerForm3({super.key, this.isSummaryScreen});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (viewModel) {},
      viewModel: ProducerFormsViewModel(),
      builder: (context, viewModel, child) {
        return isSummaryScreen == true
            ? CommonSingleChildScrollView(
                child: viewReportView(context, viewModel))
            : CommonSingleChildScrollView(
                child: fillFormView(context, viewModel));
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
      value1: "yes",
      value2: "no",
      label1: viewModel?.stringConstants.yes ?? "",
      label2: viewModel?.stringConstants.no ?? "",
      onChanged: onChanged,
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
