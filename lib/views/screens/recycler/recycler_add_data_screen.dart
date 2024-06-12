import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/recycler/recycler_add_data_viewmodel.dart';
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

class RecyclerAddDataScreen extends StatelessWidget {
  final AppColor appColor = AppColor();
  RecyclerAddDataScreen({super.key});

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
                title: viewModel.stringConstants.addRecyclerData,
              ),
              body: formSection(viewModel, context),
              persistentFooterButtons: [
                buttonSection(viewModel, context),
              ]);
        });
  }

  Container buttonSection(
      RecyclerAddDataViewModel viewModel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appColor.white,
      ),
      child: CommonButtonWidget(
        onPressed: () {
          // viewModel.formValidation(context);
          if ((viewModel.formKey.currentState?.validate() ?? false) &&
              viewModel.financialYearDropdownValue != null &&
              viewModel.recycledTyreDropdownValue != null) {
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
                        await viewModel.addRecyclerData(
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
        color: appColor.darkGreen,
        labelStyle: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: appColor.white),
      ),
    );
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
              financialYearDropdown(viewModel),
              if (viewModel.financialYearError.isNotEmpty)
                showErrorMessage(context, viewModel.financialYearError),
              nameField(viewModel),
              if (viewModel.wasteTyreSupplierNameError.isNotEmpty)
                showErrorMessage(context, viewModel.wasteTyreSupplierNameError),
              addressField(viewModel),
              if (viewModel.wasteTyreSupplierContactError.isNotEmpty)
                showErrorMessage(context, viewModel.wasteTyreSupplierContactError),
              contactDetailsField(viewModel),
              if (viewModel.wasteTyreSupplierAddressError.isNotEmpty)
                showErrorMessage(
                    context, viewModel.wasteTyreSupplierAddressError),
              recycledTyreField(viewModel),
              if (viewModel.recycledTyreError.isNotEmpty)
                showErrorMessage(context, viewModel.recycledTyreError),
              gstNoField(viewModel),
              if (viewModel.wasteTyreSupplierGstError.isNotEmpty)
                showErrorMessage(context, viewModel.wasteTyreSupplierGstError),
              qtyProcessedField(viewModel),
              if (viewModel.processedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.processedQtyError),
              qtyProducedField(viewModel),
              if (viewModel.producedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.producedQtyError),
              qtyOfWasteField(viewModel),
              if (viewModel.wasteGeneratedQtyError.isNotEmpty)
                showErrorMessage(context, viewModel.wasteGeneratedQtyError),
              dateField(viewModel, context),
              if (viewModel.recycledDateError.isNotEmpty)
                showErrorMessage(context, viewModel.recycledDateError),
            ],
          ),
        ),
      ),
    );
  }

  Padding dateField(RecyclerAddDataViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          hintText: viewModel.stringConstants.date,
          isMandatory: true,
          isReadOnly: true,
          disabledBgColor: appColor.transparent,
          validator: (value) {
            return viewModel.dateValidation();
          },
          onTap: () async {
            viewModel.date = await HelperFunctions()
                .datePicker(context, viewModel.startDate,viewModel.endDate);
            if (viewModel.date != null) {
              viewModel.dateTimeConvert();
            }
          },
          icon: ImageConstants().calendar,
          controller: viewModel.dateController),
    );
  }
    Padding contactDetailsField(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          hintText: viewModel.stringConstants.supplierContactDetails,
          textInputType: TextInputType.number,
          isMandatory: true,
          validator: (value) {
            return viewModel.contactDetailsValidation();
          },
          controller: viewModel.sellerMobileController),
    );
  }

  Padding qtyOfWasteField(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: viewModel.stringConstants.quantityOfWasteGenerated,
          textInputType: TextInputType.number,
          isMandatory: true,
          validator: (value) {
            return viewModel.quantityOfWasteGeneratedValidation();
          },
          controller: viewModel.quantityOfWasteGeneratedController),
    );
  }

  Padding qtyProducedField(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: viewModel.stringConstants.quantityProduced,
          textInputType: TextInputType.number,
          validator: (value) {
            return viewModel.quantityProducedValidation();
          },
          isMandatory: true,
          controller: viewModel.quantityProducedController),
    );
  }

  Padding qtyProcessedField(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: viewModel.stringConstants.quantityProcessed,
          textInputType: TextInputType.number,
          isMandatory: true,
          validator: (value) {
            return viewModel.quantityProcessedValidation();
          },
          controller: viewModel.quantityProcessedController),
    );
  }

  Padding gstNoField(RecyclerAddDataViewModel viewModel) {
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

  Padding recycledTyreField(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonDropdownTextFormField(
        labelText: viewModel.stringConstants.recycledTyre,
        dropDownItem: viewModel.tyreOfRecyclerMaterialList,
        error: viewModel.recycledTyreDropdownError,
        value: viewModel.recycledTyreDropdownValue,
        onTap: () {
          viewModel.changeRawMaterialDropdownValue(
              viewModel.recycledTyreDropdownValue);
        },
        onChanged: (value) {
          viewModel.changeRawMaterialDropdownValue(value);

          viewModel.recycledTyreDropdownError = null;
        },
      ),
    );
  }

  Padding addressField(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          hintText: viewModel.stringConstants.addressOfWasteTyreSupplier,
          isMandatory: true,
          validator: (value) {
            return viewModel.addressValidation();
          },
          controller: viewModel.addressController),
    );
  }

  Padding nameField(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          hintText: viewModel.stringConstants.nameOfWasteTyreSupplier,
          validator: (value) {
            return viewModel.nameValidation();
          },
          isMandatory: true,
          controller: viewModel.nameOfWasteTyreSupplierController),
    );
  }

  Padding financialYearDropdown(RecyclerAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonDropdownTextFormField(
        labelText: viewModel.stringConstants.financialYearLabel,
        dropDownItem: viewModel.financialYearList,
        error: viewModel.yearDropdownError,
        value: viewModel.financialYearDropdownValue,
        onTap: () {
          viewModel.changeFinancialDropdownValue(
              viewModel.financialYearDropdownValue);
        },
        onChanged: (value) {
          viewModel.changeFinancialDropdownValue(value);
          viewModel.yearDropdownError = null;
        },
      ),
    );
  }

  showErrorMessage(BuildContext context, String message) {
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
