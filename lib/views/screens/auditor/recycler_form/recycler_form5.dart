import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_5_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';

class AuditorRecyclerForm5 extends StatelessWidget {
  AuditorRecyclerForm5({super.key, this.isSummaryScreen = false});
  final StringConstants stringConstants = StringConstants();
  final bool? isSummaryScreen;

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm5ViewModel>(
        onModelReady: (value) {},
        viewModel: RecyclerForm5ViewModel(),
        builder: (context, viewModel, child) {
          return isSummaryScreen == false
              ? form5View(viewModel)
              : summaryForm5View(viewModel);
        });
  }

  Padding summaryForm5View(RecyclerForm5ViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonMandatoryTitle(
                title: stringConstants.whetherEtpInstalled),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonDropdownTextFormField(
              hideIcon: isSummaryScreen,
              bgColor: AppColor().black10,
              labelText: stringConstants.select,
              dropDownItem: const ["Yes", "No"],
              value: viewModel.installDropdownValue,
              onChanged: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                isReadOnly: isSummaryScreen,
                hintText: stringConstants.remarks.i18n(),
                isMandatory: false,
                controller: viewModel.etpRemarksInstalledController),
          ),
          formRadioButton(
            groupValue: viewModel.radioInstalled,
            onChanged: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonMandatoryTitle(title: stringConstants.etpCapacity),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: CommonTextFormFieldWidget(
              isReadOnly: isSummaryScreen,
              hintText: stringConstants.enter,
              isMandatory: false,
              controller: viewModel.etpCapacityController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: CommonTextFormFieldWidget(
                isReadOnly: isSummaryScreen,
                hintText: stringConstants.remarks.i18n(),
                isMandatory: false,
                controller: viewModel.etpRemarksCapacityController),
          ),
          formRadioButton(
            groupValue: viewModel.radioCapacity,
            onChanged: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:
                CommonTitleWidget(label: stringConstants.summaryOfAuditTitle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonMandatoryTitle(
              title: stringConstants.summaryOfAudit,
              isMandatory: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
              isReadOnly: isSummaryScreen,
              maxLength: 500,
              maxLines: 4,
              isMandatory: false,
              hintText: stringConstants.textHere.i18n(),
              controller: viewModel.summmaryRemakrController,
            ),
          )
        ],
      ),
    );
  }

  Padding form5View(RecyclerForm5ViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonMandatoryTitle(
                title: stringConstants.whetherEtpInstalled),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonDropdownTextFormField(
              labelText: stringConstants.select,
              dropDownItem: const ["Yes", "No"],
              value: viewModel.installDropdownValue,
              onChanged: (value) {
                viewModel.changeDropdownValue(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                hintText: stringConstants.remarks.i18n(),
                isMandatory: false,
                controller: viewModel.etpRemarksInstalledController),
          ),
          formRadioButton(
            groupValue: viewModel.radioInstalled,
            onChanged: (value) {
              viewModel.radioInstalled = value ?? '';
              viewModel.updateUI();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonMandatoryTitle(title: stringConstants.etpCapacity),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: CommonTextFormFieldWidget(
              hintText: stringConstants.enter,
              isMandatory: false,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType: TextInputType.number,
              controller: viewModel.etpCapacityController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: CommonTextFormFieldWidget(
                hintText: stringConstants.remarks.i18n(),
                isMandatory: false,
                controller: viewModel.etpRemarksCapacityController),
          ),
          formRadioButton(
            groupValue: viewModel.radioCapacity,
            onChanged: (value) {
              viewModel.radioCapacity = value ?? '';
              viewModel.updateUI();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:
                CommonTitleWidget(label: stringConstants.summaryOfAuditTitle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonMandatoryTitle(
              title: stringConstants.summaryOfAudit,
              isMandatory: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
              maxLength: 500,
              maxLines: 4,
              validator: (value) {
                return viewModel.summaryValidation();
              },
              isMandatory: false,
              hintText: stringConstants.textHere.i18n(),
              controller: viewModel.summmaryRemakrController,
            ),
          )
        ],
      ),
    );
  }

  CommonRadioButton formRadioButton(
      {String? groupValue, void Function(String?)? onChanged}) {
    return CommonRadioButton(
        groupValue: groupValue ?? '',
        value1: stringConstants.notConfirmed,
        value2: stringConstants.confirmed,
        label1: stringConstants.notConfirmed,
        label2: stringConstants.confirmed,
        onChanged: onChanged);
  }
}
