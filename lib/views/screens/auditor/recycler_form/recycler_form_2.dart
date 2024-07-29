import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
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

class AuditorRecyclerForm2 extends StatefulWidget {
  final bool? isSummaryScreen;
  final bool isRetreader;
  final String? id;
  final String? userType;
  const AuditorRecyclerForm2(
      {super.key,
      this.isSummaryScreen = false,
      this.isRetreader = false,
      this.id,
      this.userType});

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
    viewModel.initializeForm2TextEditingController();
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
                      child: form2View(
                          viewModel, context, widget.userType == "Retreader")),
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
                        : await viewModel.recyclerPostForm2Data(context,
                            id: widget.id,
                            isRetreader: widget.userType == "Retreader");
                  },
                  onSavedDraft: () async {
                    await viewModel.recyclerPostForm2Data(context,
                        id: widget.id, saveAsDraft: "SaveAsDraft");
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
                controller: viewModel.typeOfProductController ??
                    TextEditingController(),
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
                controller: viewModel.areValuedCandDController ??
                    TextEditingController(),
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
          (widget.userType == "Retreader") == false
              ? Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: CommonTextFormFieldWidget(
                    isMandatory: true,
                    bgColor: appColor.white,
                    hintText: stringConstants.select,
                    icon: ImageConstants().dropdownIcon,
                    controller: viewModel.endProductDataListController ??
                        TextEditingController(),
                    isReadOnly: true,
                    disabledBgColor: appColor.white,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context1) {
                          return Dialog(
                            insetPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: AppColor().white,
                            surfaceTintColor: AppColor().white,
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * .42,
                                width: MediaQuery.of(context).size.width * .9,
                                // padding: const EdgeInsets.all(24),
                                margin: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColor().white,
                                    borderRadius: BorderRadius.circular(6)),
                                child: ListView.builder(
                                    itemCount: viewModel.endProductsList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                value: viewModel
                                                    .endProductsList[index]
                                                    .isChecked,
                                                activeColor: AppColor().green,
                                                onChanged: (val) {
                                                  viewModel.updateCheckBox(
                                                      val ?? false, index);
                                                  HelperFunctions().logger(
                                                      "${viewModel.selectedEndProductsData}");
                                                  setState(() {});
                                                }),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: CommonTextWidget(
                                                    viewModel
                                                        .endProductsList[index]
                                                        .title),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              );
                            }),
                          );
                        },
                      ).whenComplete(() {
                        viewModel.updateUI();
                      });
                    },
                  ),
                )
              : CommonTextFormFieldWidget(
                  hintText: stringConstants.enter,
                  isReadOnly: true,
                  isMandatory: false,
                  controller: TextEditingController()),
          if (viewModel.capacityTypeofEndProductError?.isNotEmpty ?? false)
            showErrorMessage(
                context, viewModel.capacityTypeofEndProductError ?? ""),
          commonRecyclerForm2Tile(
              title: stringConstants.plantProductionCapacity,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel.emptyValidation(
                    viewModel.plantProductionCapacityController);
              },
              textEditingController:
                  viewModel.plantProductionCapacityController),
          if (viewModel.plantProductionCapacityError?.isNotEmpty ?? false)
            showErrorMessage(
                context, viewModel.plantProductionCapacityError ?? ""),
          commonRecyclerForm2Tile(
              title: stringConstants.endProductProduced,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.endProductProducedController);
              },
              textEditingController: viewModel.endProductProducedController),
          if (viewModel.capacityTypeofEndProductError?.isNotEmpty ?? false)
            showErrorMessage(
                context, viewModel.capacityTypeofEndProductError ?? ""),
          commonRecyclerForm2Tile(
              title: stringConstants.daysPlantOperational,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.daysPlantOperationalController);
              },
              textEditingController: viewModel.daysPlantOperationalController),
          if (viewModel.plantPerDayError?.isNotEmpty ?? false)
            showErrorMessage(context, viewModel.plantPerDayError ?? ""),
          commonRecyclerForm2Tile(
              title: stringConstants.hoursPlantOperational,
              hintText: stringConstants.enter,
              validator: (value) {
                return viewModel
                    .emptyValidation(viewModel.hoursPlantOperationalController);
              },
              textEditingController: viewModel.hoursPlantOperationalController),
          if (viewModel.plantPerYearError?.isNotEmpty ?? false)
            showErrorMessage(context, viewModel.plantPerYearError ?? ""),
          commonRecyclerForm2Tile(
            title: stringConstants.shiftPlantOperational,
            hintText: stringConstants.enter,
            textEditingController: viewModel.shiftPlantOperationalController,
            validator: (value) {
              return viewModel
                  .emptyValidation(viewModel.shiftPlantOperationalController);
            },
          ),
          if (viewModel.plantPerShiftError?.isNotEmpty ?? false)
            showErrorMessage(context, viewModel.plantPerShiftError ?? ""),
          commonRecyclerForm2Tile(
              title: stringConstants.actualProcessingCapacity,
              hintText: stringConstants.enter,
              textEditingController:
                  viewModel.actualProcessingCapacityController,
              isDisable: true),
          if (viewModel.actualProcessingCapacityError?.isNotEmpty ?? false)
            showErrorMessage(
                context, viewModel.actualProcessingCapacityError ?? ""),
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
          if (viewModel.powerOnAuditDayError?.isNotEmpty ?? false)
            showErrorMessage(context, viewModel.powerOnAuditDayError ?? ""),
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
          if (viewModel.totalElectricityConsumptionError?.isNotEmpty ?? false)
            showErrorMessage(
                context, viewModel.totalElectricityConsumptionError ?? ""),
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
                controller: viewModel.areValuedCandDController ??
                    TextEditingController(),
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
