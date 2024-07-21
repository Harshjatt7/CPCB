import 'package:cpcb_tyre/constants/enums/state_enums.dart';
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
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/forms/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class AuditorRecyclerForm2 extends StatefulWidget {
  const AuditorRecyclerForm2(
      {super.key, this.isSummaryScreen = false, this.isRetreader = false,this.id});
  final bool? isSummaryScreen;
  final bool isRetreader;
  final String? id;

  @override
  State<AuditorRecyclerForm2> createState() => _AuditorRecyclerForm2State();
}

class _AuditorRecyclerForm2State extends State<AuditorRecyclerForm2> {
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
    return Consumer<RecyclerFormViewModel>(
      builder: (context, value, child) {
        return Stack(
          children: [
            Opacity(
              opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
              child: widget.isSummaryScreen == true
                  ? CommonSingleChildScrollView(
                      child: summaryForm2View(viewModel, context))
                  : CommonSingleChildScrollView(
                      child: form2View(viewModel, context, widget.isRetreader)),
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

  Widget summaryForm2View(
      RecyclerFormViewModel viewModel, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: stringConstants.plantCapacityAssessment),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CommonMandatoryTitle(
              title: stringConstants.typeOfEndProduct,
              isMandatory: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: CommonTextFormFieldWidget(
                bgColor: appColor.black10,
                hintText: stringConstants.select,
                controller: viewModel.typeOfProductController,
                isReadOnly: true,
                isMandatory: false,
                onChanged: null),
          ),
          commonRecyclerForm2Tile(
              title: stringConstants.plantProductionCapacity,
              hintText: stringConstants.enter,
              isDisable: true,
              textEditingController:
                  viewModel.plantProductionCapacityController),
          commonRecyclerForm2Tile(
              title: stringConstants.endProductProduced,
              hintText: stringConstants.enter,
              isDisable: true,
              textEditingController: viewModel.endProductProducedController),
          commonRecyclerForm2Tile(
              title: stringConstants.daysPlantOperational,
              hintText: stringConstants.enter,
              isDisable: true,
              textEditingController: viewModel.daysPlantOperationalController),
          commonRecyclerForm2Tile(
              title: stringConstants.hoursPlantOperational,
              hintText: stringConstants.enter,
              isDisable: true,
              textEditingController: viewModel.hoursPlantOperationalController),
          commonRecyclerForm2Tile(
            title: stringConstants.shiftPlantOperational,
            hintText: stringConstants.enter,
            isDisable: true,
            textEditingController: viewModel.shiftPlantOperationalController,
          ),
          commonRecyclerForm2Tile(
              title: stringConstants.actualProcessingCapacity,
              hintText: stringConstants.enter,
              textEditingController:
                  viewModel.actualProcessingCapacityController,
              isDisable: true),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: CommonTitleWidget(label: stringConstants.areValueComparable),
          ),
          CommonRadioButton(
            groupValue: viewModel.radioxy,
            value1: stringConstants.radioValue1,
            value2: stringConstants.radioValue2,
            label1: stringConstants.notConfirmed,
            label2: stringConstants.confirmed,
            onChanged: null,
          ),
          commonRecyclerForm2Tile(
              title: stringConstants.differenceInActualProccessing,
              hintText: stringConstants.enter,
              textEditingController:
                  viewModel.differenceInActualProccessingController,
              isDisable: true),
          commonRecyclerForm2Tile(
              title: stringConstants.totalQuantitySales,
              hintText: "",
              textEditingController: viewModel.totalQuantitySalesController,
              isDisable: true),
          commonRecyclerForm2Tile(
              title: stringConstants.uploadSales,
              hintText: "",
              textEditingController: viewModel.uploadSalesController,
              isDisable: true),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: CommonTitleWidget(
                label: stringConstants.electricityVerification),
          ),
          commonRecyclerForm2Tile(
              title: stringConstants.powerConsumptionDuringAudit,
              hintText: stringConstants.enter,
              textEditingController: viewModel.powerConsumptionController,
              isDisable: true),
          commonRecyclerForm2Tile(
              title: stringConstants.actualAverageAnnual,
              hintText: stringConstants.enter,
              textEditingController: viewModel.actualAverageAnnualController,
              isDisable: true),
          commonRecyclerForm2Tile(
              title: stringConstants.totalElectricityConsumed,
              hintText: stringConstants.enter,
              textEditingController: viewModel.totalElectricityController,
              isDisable: true),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
            ),
            child: CommonTextWidget(
              stringConstants.areValuedCandD,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          CommonRadioButton(
              groupValue: viewModel.radiocd,
              value1: stringConstants.radioValue1,
              value2: stringConstants.radioValue2,
              label1: stringConstants.notConfirmed,
              label2: stringConstants.confirmed,
              onChanged: null),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                isReadOnly: true,
                bgColor: appColor.white,
                controller: viewModel.areValuedCandDController,
                maxLength: 100,
                isMandatory: false,
                hintText: stringConstants.remarks.i18n()),
          )
        ],
      ),
    );
  }

  Widget form2View(
      RecyclerFormViewModel viewModel, BuildContext context, bool isRetreader) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: stringConstants.plantCapacityAssessment),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CommonMandatoryTitle(
              title: stringConstants.typeOfEndProduct,
              isMandatory: true,
            ),
          ),
          isRetreader == false
              ? Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: CommonDropdownTextFormField(
                    bgColor: appColor.white,
                    labelText: stringConstants.select,
                    dropDownItem: viewModel.typeOfEndProduct,
                    error: viewModel.endProductDropDownError,
                    value: viewModel.endProductDropdownValue,
                    onTap: () {
                      viewModel.endProductChangeDropDown(
                          viewModel.endProductDropdownValue);
                    },
                    onChanged: (value) {
                      viewModel.endProductChangeDropDown(value);

                      viewModel.endProductDropDownError = null;
                    },
                  ),
                )
              : CommonTextFormFieldWidget(
                  hintText: stringConstants.enter,
                  isReadOnly: true,
                  isMandatory: false,
                  controller: TextEditingController()),
          commonRecyclerForm2Tile(
              title: stringConstants.plantProductionCapacity,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel.emptyValidation(
                    viewModel.plantProductionCapacityController);
              },
              textEditingController:
                  viewModel.plantProductionCapacityController),
          commonRecyclerForm2Tile(
              title: stringConstants.endProductProduced,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.endProductProducedController);
              },
              textEditingController: viewModel.endProductProducedController),
          commonRecyclerForm2Tile(
              title: stringConstants.daysPlantOperational,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.daysPlantOperationalController);
              },
              textEditingController: viewModel.daysPlantOperationalController),
          commonRecyclerForm2Tile(
              title: stringConstants.hoursPlantOperational,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.hoursPlantOperationalController);
              },
              textEditingController: viewModel.hoursPlantOperationalController),
          commonRecyclerForm2Tile(
            title: stringConstants.shiftPlantOperational,
            hintText: stringConstants.enter,
            textEditingController: viewModel.shiftPlantOperationalController,
            validator: (value) {
              return viewModel
                  .emptyValidation(viewModel.shiftPlantOperationalController);
            },
          ),
          commonRecyclerForm2Tile(
              title: stringConstants.actualProcessingCapacity,
              hintText: stringConstants.enter,
              textEditingController:
                  viewModel.actualProcessingCapacityController,
              isDisable: true),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: CommonTitleWidget(label: stringConstants.areValueComparable),
          ),
          CommonRadioButton(
            groupValue: viewModel.radioxy,
            value1: stringConstants.radioValue1,
            value2: stringConstants.radioValue2,
            label1: stringConstants.notConfirmed,
            label2: stringConstants.confirmed,
            onChanged: (value) {
              viewModel.radioxy = value ?? '';
              viewModel.updateUI();
            },
          ),
          commonRecyclerForm2Tile(
              title: stringConstants.differenceInActualProccessing,
              hintText: stringConstants.enter,
              textEditingController:
                  viewModel.differenceInActualProccessingController,
              validator: (value) {
                return viewModel.emptyValidation(
                    viewModel.differenceInActualProccessingController);
              },
              isDisable: false),
          commonRecyclerForm2Tile(
              title: stringConstants.totalQuantitySales,
              hintText: stringConstants.enter,
              textEditingController: viewModel.totalQuantitySalesController,
              isDisable: true),
          commonRecyclerForm2Tile(
              title: stringConstants.uploadSales,
              hintText: stringConstants.enter,
              textEditingController: viewModel.uploadSalesController,
              isDisable: true),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: CommonTitleWidget(
                label: stringConstants.electricityVerification),
          ),
          commonRecyclerForm2Tile(
              title: stringConstants.powerConsumptionDuringAudit,
              hintText: stringConstants.enter,
              textEditingController: viewModel.powerConsumptionController,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.powerConsumptionController);
              },
              isDisable: false),
          commonRecyclerForm2Tile(
              title: stringConstants.actualAverageAnnual,
              hintText: stringConstants.enter,
              textEditingController: viewModel.actualAverageAnnualController,
              isDisable: true),
          commonRecyclerForm2Tile(
              title: stringConstants.totalElectricityConsumed,
              hintText: stringConstants.enter,
              textEditingController: viewModel.totalElectricityController,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.totalElectricityController);
              },
              isDisable: false),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
            ),
            child: CommonTextWidget(
              stringConstants.areValuedCandD,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          CommonRadioButton(
            groupValue: viewModel.radiocd,
            value1: stringConstants.radioValue1,
            value2: stringConstants.radioValue2,
            label1: stringConstants.notConfirmed,
            label2: stringConstants.confirmed,
            onChanged: (value) {
              viewModel.radiocd = value ?? '';
              viewModel.updateUI();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                bgColor: appColor.white,
                controller: viewModel.areValuedCandDController,
                maxLength: 100,
                isMandatory: false,
                validator: (value) {
                  return viewModel
                      .emptyValidation(viewModel.areValuedCandDController);
                },
                hintText: stringConstants.remarks.i18n()),
          )
        ],
      ),
    );
  }

  Column commonRecyclerForm2Tile(
      {String? title,
      String? hintText,
      TextEditingController? textEditingController,
      String? Function(String?)? validator,
      bool isDisable = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CommonMandatoryTitle(
            title: title ?? '',
            isMandatory: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(),
          child: CommonTextFormFieldWidget(
              bgColor: appColor.white,
              isReadOnly: isDisable,
              hintText: hintText ?? "",
              isMandatory: false,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType: TextInputType.number,
              validator: validator,
              controller: textEditingController ?? TextEditingController()),
        ),
      ],
    );
  }
}
