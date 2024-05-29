import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/recycler/recycler_add_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/retrader/retreaded_add_data_screen.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_pop_up.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecyclerAddDataScreen extends StatelessWidget {
  const RecyclerAddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerAddDataViewModel>(
        onModelReady: (viewModel) async {
          await viewModel.getRecyclerDataConstants();
        },
        viewModel: RecyclerAddDataViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              resizeToBottomInset: true,
              isLoading: viewModel.state == ViewState.busy,
              appBar: CommonAppBar(
                title: StringConstants().addRecyclerData,
              ),
              body: formSection(viewModel, context),
              persistentFooterButtons: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor().white,
                  ),
                  child: CommonButtonWidget(
                    onPressed: () {
                      viewModel.formValidation(context);
                      if ((viewModel.formKey.currentState?.validate() ??
                              false) &&
                          viewModel.changeDropdown != null) {
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
                                    viewModel.addRecyclerData(
                                      context,
                                    );
                                  }
                                },
                              );
                            });
                      }
                    },
                    height: 50,
                    label: StringConstants().submitBtnLabel,
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
      RecyclerAddDataViewModel viewModel, BuildContext context) {
    return CommonSingleChildScrollView(
      child: Form(
        key: viewModel.formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  labelText: StringConstants().financialYearLabel,
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
              ),
              if (viewModel.financialYearError.isNotEmpty)
                showErrorMessage(context, viewModel.financialYearError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().nameOfWasteTyreSupplier,
                    isMandatory: false,
                    controller: viewModel.nameOfWasteTyreSupplierController),
              ),
              if (viewModel.wasteTyreSupplierNameError.isNotEmpty)
                showErrorMessage(context, viewModel.wasteTyreSupplierNameError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  hintText: StringConstants().contactDetails,
                  isMandatory: false,
                  controller: viewModel.contactDetailsController,
                  validator: (value) {
                    return viewModel.contactDetailsValidation();
                  },
                ),
              ),
              if (viewModel.wasteTyreSupplierContactError.isNotEmpty)
                showErrorMessage(
                    context, viewModel.wasteTyreSupplierContactError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().addressOfWasteTyreSupplier,
                    isMandatory: false,
                    controller: viewModel.addressController),
              ),
              if (viewModel.wasteTyreSupplierAddressError.isNotEmpty)
                showErrorMessage(
                    context, viewModel.wasteTyreSupplierAddressError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  labelText: StringConstants().typeOfRawMaterial,
                  dropDownItem: viewModel.tyreOfRecyclerMaterialList,
                  error: viewModel.tyreOfRecyclerMaterialDropdownError,
                  value: viewModel.tyreOfRecyclerMaterialDropdownValue,
                  onTap: () {
                    viewModel.changeRawMaterialDropdownValue(
                        viewModel.tyreOfRecyclerMaterialDropdownValue);
                  },
                  onChanged: (value) {
                    viewModel.changeRawMaterialDropdownValue(value);
                    viewModel.tyreOfRecyclerMaterialDropdownError = null;
                  },
                ),
              ),
              if (viewModel.typeOfRecycledMaterialError.isNotEmpty)
                showErrorMessage(
                    context, viewModel.typeOfRecycledMaterialError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    hintText: StringConstants().gstNumberOfWasteTyreSupplier,
                    validator: (value) {
                      return viewModel.gstNumberValidation();
                    },
                    isMandatory: true,
                    controller: viewModel.gstController),
              ),
              if (viewModel.wasteTyreSupplierGstError.isNotEmpty)
                showErrorMessage(context, viewModel.wasteTyreSupplierGstError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: StringConstants().quantityProcessed,
                    textInputType: TextInputType.number,
                    isMandatory: true,
                    validator: (value) {
                      return viewModel.quantityProcessedValidation();
                    },
                    controller: viewModel.quantityProcessedController),
              ),
              if (viewModel.processedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.processedQtyError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: StringConstants().quantityProduced,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      return viewModel.quantityProducedValidation();
                    },
                    isMandatory: true,
                    controller: viewModel.quantityProducedController),
              ),
              if (viewModel.producedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.producedQtyError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: StringConstants().quantityOfWasteGenerated,
                    textInputType: TextInputType.number,
                    isMandatory: true,
                    validator: (value) {
                      return viewModel.quantityOfWasteGeneratedValidation();
                    },
                    controller: viewModel.quantityOfWasteGeneratedController),
              ),
              if (viewModel.wasteGeneratedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.wasteGeneratedQtyError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().date,
                    isMandatory: true,
                    isReadOnly: true,
                    disabledBgColor: AppColor().transparent,
                    validator: (value) {
                      return viewModel.dateValidation();
                    },
                    onTap: () async {
                      viewModel.date = await HelperFunctions()
                          .datePicker(context, viewModel.startDate);
                      if (viewModel.date != null) {
                        viewModel.dateTimeConvert();
                      }
                    },
                    icon: ImageConstants().calendar,
                    controller: viewModel.dateController),
              ),
              if (viewModel.recycledDateError.isNotEmpty)
                showErrorMessage(context, viewModel.recycledDateError),
            ],
          ),
        ),
      ),
    );
  }
}
