import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_2_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';

class AuditorRecyclerForm2 extends StatelessWidget {
  AuditorRecyclerForm2({super.key});
  final AppColor appColor = AppColor();
  final StringConstants stringConstants = StringConstants();

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm2ViewModel>(
      onModelReady: (viewModel) {},
      viewModel: RecyclerForm2ViewModel(),
      builder: (context, viewModel, child) {
        return Padding(
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
                child: CommonDropdownTextFormField(
                    bgColor: appColor.white,
                    labelText: stringConstants.select,
                    dropDownItem: const [],
                    onChanged: null),
              ),
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
                    return viewModel.emptyValidation(
                        viewModel.endProductProducedController);
                  },
                  textEditingController:
                      viewModel.endProductProducedController),
              commonRecyclerForm2Tile(
                  title: stringConstants.daysPlantOperational,
                  hintText: stringConstants.enter,
                  validator: (value) {
                    return viewModel.emptyValidation(
                        viewModel.daysPlantOperationalController);
                  },
                  textEditingController:
                      viewModel.daysPlantOperationalController),
              commonRecyclerForm2Tile(
                  title: stringConstants.hoursPlantOperational,
                  hintText: stringConstants.enter,
                  validator: (value) {
                    return viewModel.emptyValidation(
                        viewModel.hoursPlantOperationalController);
                  },
                  textEditingController:
                      viewModel.hoursPlantOperationalController),
              commonRecyclerForm2Tile(
                title: stringConstants.shiftPlantOperational,
                hintText: stringConstants.enter,
                textEditingController:
                    viewModel.shiftPlantOperationalController,
                validator: (value) {
                  return viewModel.emptyValidation(
                      viewModel.shiftPlantOperationalController);
                },
              ),
              commonRecyclerForm2Tile(
                  title: stringConstants.actualProcessingCapacity,
                  hintText: "", //Value will come from API
                  textEditingController:
                      viewModel.actualProcessingCapacityController,
                  isDisable: true),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: CommonTitleWidget(
                    label: stringConstants.areValueComparable),
              ),
              CommonRadioButton(
                groupValue: viewModel.radioxy,
                value1: stringConstants.notConfirmed,
                value2: stringConstants.confirmed,
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
                  hintText: "", //Value will come from API
                  textEditingController: viewModel.totalQuantitySalesController,
                  isDisable: true),
              commonRecyclerForm2Tile(
                  title: stringConstants.uploadSales,
                  hintText: "", //Value will come from API
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
                  textEditingController:
                      viewModel.actualAverageAnnualController,
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
                value1: stringConstants.notConfirmed,
                value2: stringConstants.confirmed,
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
      },
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
              disabledBgColor: appColor.black10,
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
