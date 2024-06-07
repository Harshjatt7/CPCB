import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/retreaded_add_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_pop_up.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RetreadedAddDataScreen extends StatelessWidget {
  final int? page;
  const RetreadedAddDataScreen({super.key, this.page});

  @override
  Widget build(BuildContext context) {
    return BaseView<RetreadedAddDataViewModel>(
        onModelReady: (viewModel) {
          viewModel.addYear();
        },
        viewModel: RetreadedAddDataViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              resizeToBottomInset: true,
              isLoading: viewModel.state == ViewState.busy,
              appBar: CommonAppBar(
                title: viewModel.stringConstants.addRetreadedData,
              ),
              body: formSection(viewModel, context),
              persistentFooterButtons: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor().white,
                  ),
                  child: CommonButtonWidget(
                    onPressed: () async {
                      viewModel.formValidation();
                      if (viewModel.formKey.currentState?.validate() ?? false) {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return CommonPopUp(
                                onPressedNo: () {
                                  Navigator.pop(ctx);
                                },
                                onPressedYes: () async {
                                  Navigator.pop(ctx);
                                  if (context.mounted) {
                                    await viewModel.addRetreadedData(
                                      context,
                                    );
                                  }
                                },
                              );
                            });
                      }
                    },
                    height: 50,
                    label: viewModel.stringConstants.submitBtnLabel,
                    color: AppColor().darkGreen,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColor().white),
                  ),
                ),
              ]);
        });
  }

  CommonSingleChildScrollView formSection(
      RetreadedAddDataViewModel viewModel, BuildContext context) {
    return CommonSingleChildScrollView(
      child: Form(
        key: viewModel.formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              financialYearDropdown(viewModel),
              if (viewModel.financialYearError.isNotEmpty)
                showErrorMessage(context, viewModel.financialYearError),
              supplierName(viewModel),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  hintText: viewModel.stringConstants.contactDetails,
                  isMandatory: false,
                  controller: viewModel.contactDetailsController,
                  validator: (value) {
                    return viewModel.nameValidation();
                  },
                ),
              ),
              supplierAddress(viewModel),
              typeOfRawMaterial(viewModel),
              gstNumber(viewModel),
              processedQuantity(viewModel),
              if (viewModel.processedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.processedQtyError),
              producedQuantity(viewModel),
              if (viewModel.producedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.producedQtyError),
              quantityOfGeneratedWaste(viewModel),
              retreadedData(context, viewModel),
              if (viewModel.retreadedDateError.isNotEmpty)
                showErrorMessage(context, viewModel.retreadedDateError),
            ],
          ),
        ),
      ),
    );
  }

  Widget retreadedData(
      BuildContext context, RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          hintText: viewModel.stringConstants.retreadedDate,
          isMandatory: true,
          isReadOnly: true,
          validator: (value) {
            return viewModel.dateValidation();
          },
          disabledBgColor: AppColor().transparent,
          onTap: () async {
            viewModel.date = await HelperFunctions()
                .datePicker(context, viewModel.startDate);
            if (viewModel.date != null) {
              viewModel.dateTimeConvert();
            }
          },
          icon: ImageConstants().calendar,
          controller: viewModel.dateController),
    );
  }

  Widget quantityOfGeneratedWaste(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: viewModel.stringConstants.quantityOfWasteGenerated,
          isMandatory: true,
          validator: (value) {
            return viewModel.quantityOfWasteGeneratedValidation();
          },
          controller: viewModel.quantityOfWasteGeneratedController),
    );
  }

  Widget producedQuantity(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: viewModel.stringConstants.quantityProduced,
          validator: (value) {
            return viewModel.quantityProducedValidation();
          },
          isMandatory: true,
          controller: viewModel.quantityProducedController),
    );
  }

  Widget processedQuantity(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: viewModel.stringConstants.quantityProcessed,
          isMandatory: true,
          validator: (value) {
            return viewModel.quantityProcessedValidation();
          },
          controller: viewModel.quantityProcessedController),
    );
  }

  Widget gstNumber(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [LengthLimitingTextInputFormatter(15)],
          hintText: viewModel.stringConstants.gstNumberOfWasteTyreSupplier,
          validator: (value) {
            return viewModel.gstNumberValidation();
          },
          isMandatory: true,
          controller: viewModel.gstController),
    );
  }

  Widget typeOfRawMaterial(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
        hintText: viewModel.stringConstants.typeOfRawMaterial,
        isMandatory: true,
        controller: viewModel.typeOfRawMaterialController,
        isReadOnly: true,
        disabledBgColor: AppColor().transparent,
      ),
    );
  }

  Widget supplierAddress(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          hintText: viewModel.stringConstants.addressOfWasteTyreSupplier,
          isMandatory: false,
          controller: viewModel.addressController),
    );
  }

  Widget supplierName(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          hintText: viewModel.stringConstants.nameOfWasteTyreSupplier,
          isMandatory: false,
          controller: viewModel.nameOfWasteTyreSupplierController),
    );
  }

  Widget financialYearDropdown(RetreadedAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonDropdownTextFormField(
        labelText: viewModel.stringConstants.financialYearLabel,
        dropDownItem: viewModel.financialYearList,
        error: viewModel.yearDropdownError,
        value: viewModel.yearDropdownValue,
        onTap: () {
          viewModel.changeDropdownValue(viewModel.yearDropdownValue);
        },
        onChanged: (value) {
          viewModel.changeDropdownValue(value);
          viewModel.yearDropdownError = null;
        },
      ),
    );
  }
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
            ?.copyWith(color: AppColor().red),
      ),
    ),
  );
}
