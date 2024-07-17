import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/forms/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class AuditorRecyclerForm5 extends StatefulWidget {
  const AuditorRecyclerForm5({super.key, this.isSummaryScreen = false});
  final bool? isSummaryScreen;

  @override
  State<AuditorRecyclerForm5> createState() => _AuditorRecyclerForm5State();
}

class _AuditorRecyclerForm5State extends State<AuditorRecyclerForm5> {
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
    return Consumer<RecyclerFormViewModel>(
      builder: (context, value, child) {
        return Stack(
          children: [
            widget.isSummaryScreen == true
                ? CommonSingleChildScrollView(
                    child: summaryForm5View(viewModel))
                : CommonSingleChildScrollView(child: form5View(viewModel)),
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

  Widget summaryForm5View(RecyclerFormViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 120),
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
              hideIcon: widget.isSummaryScreen,
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
                isReadOnly: widget.isSummaryScreen,
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
              isReadOnly: widget.isSummaryScreen,
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
                isReadOnly: widget.isSummaryScreen,
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
              isReadOnly: widget.isSummaryScreen,
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

  Widget form5View(RecyclerFormViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 120),
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
                viewModel.installChangeDropdownValue(value);
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
        value1: stringConstants.radioValue1,
        value2: stringConstants.radioValue2,
        label1: stringConstants.notConfirmed,
        label2: stringConstants.confirmed,
        onChanged: onChanged);
  }
}
