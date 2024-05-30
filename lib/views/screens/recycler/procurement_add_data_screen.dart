import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/recycler/recycler_procurement_add_data_viewmodel.dart';
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

class RecyclerProcurementAddDataScreen extends StatelessWidget {
  const RecyclerProcurementAddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerProcurementAddDataViewModel>(
        viewModel: RecyclerProcurementAddDataViewModel(),
        onModelReady: (viewModel) async {
          await viewModel.getData();
        },
        builder: (context, viewModel, child) {
          return CustomScaffold(
              isLoading: viewModel.state == ViewState.busy,
              resizeToBottomInset: true,
              appBar: CommonAppBar(
                title: StringConstants().addProcurement,
              ),
              body: CommonSingleChildScrollView(
                child: Form(
                  key: viewModel.formKey,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      children: [
                        financialYearDropdown(viewModel),
                        if (viewModel.financialYearError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.financialYearError ?? ''),
                        nameField(viewModel),
                        if (viewModel.supplierNameError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.supplierNameError ?? ''),
                        contactDetailsField(viewModel),
                        if (viewModel.supplierContactError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.supplierContactError ?? ''),
                        addressOfWasteSupplierField(viewModel),
                        if (viewModel.addressError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.addressError ?? ''),
                        rawMaterialDropdown(viewModel),
                        if (viewModel.rawMaterialError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.rawMaterialError ?? ''),
                        tyreSourceDropdown(viewModel),
                        if (viewModel.sourceTyreError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.sourceTyreError ?? ''),
                        quantityReceivedField(viewModel),
                        if (viewModel.quantityReceivedError?.isNotEmpty ??
                            false)
                          showErrorMessage(
                              context, viewModel.quantityReceivedError ?? ''),
                        uploadInvoiceField(viewModel, context),
                        if (viewModel.uploadInvoiceError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.uploadInvoiceError ?? ''),
                        invoiceNumberField(viewModel),
                        if (viewModel.invoiceNumberError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.invoiceNumberError ?? ''),
                        gstNumebrField(viewModel),
                        if (viewModel.gstNumberError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.gstNumberError ?? ''),
                        purchasedDateField(viewModel, context),
                        if (viewModel.purchaseDateError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.purchaseDateError ?? ''),
                      ],
                    ),
                  ),
                ),
              ),
              persistentFooterButtons: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor().white,
                  ),
                  child: CommonButtonWidget(
                    onPressed: () {
                      viewModel.formValidation(
                        context,
                      );
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
                                    viewModel.postData(context);
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

  Padding purchasedDateField(
      RecyclerProcurementAddDataViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          disabledBgColor: AppColor().transparent,
          isReadOnly: true,
          onTap: () async {
            viewModel.date = await HelperFunctions()
                .datePicker(context, viewModel.startDate);
            if (viewModel.date != null) {
              viewModel.dateTimeConvert();
            }
          },
          validator: (value) {
            return viewModel.dateValidation();
          },
          hintText: StringConstants().dateOfPurchaseOfRawMaterial,
          isMandatory: true,
          icon: ImageConstants().calendar,
          controller: viewModel.dateController),
    );
  }

  Padding gstNumebrField(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [LengthLimitingTextInputFormatter(15)],
          hintText: StringConstants().gstNumberOfWasteTyreSupplier,
          validator: (value) {
            return viewModel.gstNumberValidation();
          },
          isMandatory: true,
          controller: viewModel.gstController),
    );
  }

  Padding invoiceNumberField(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputType: TextInputType.number,
          hintText: StringConstants().invoiceNumber,
          isMandatory: true,
          validator: (value) {
            return viewModel.valueValidation(viewModel.invoiceNumberController);
          },
          controller: viewModel.invoiceNumberController),
    );
  }

  Padding financialYearDropdown(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonDropdownTextFormField(
        error: viewModel.yearDropdownError,
        onTap: () {
          viewModel.changeFinancialDropdownValue(
            viewModel.financialYearDropdownValue,
          );
        },
        value: viewModel.financialYearDropdownValue,
        labelText: StringConstants().financialYearLabel,
        dropDownItem: viewModel.financialYearList,
        onChanged: (value) {
          viewModel.changeFinancialDropdownValue(
            value,
          );
          viewModel.yearDropdownError = null;
        },
      ),
    );
  }

  Padding uploadInvoiceField(
      RecyclerProcurementAddDataViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          isDocument: viewModel.filePath == null ? false : true,
          disabledBgColor: AppColor().transparent,
          isReadOnly: true,
          hintText: StringConstants().uploadInvoice,
          icon: viewModel.uploadInvoiceController.text.isEmpty
              ? ImageConstants().fileUpload
              : ImageConstants().removeIcon,
          onTap: () {
            viewModel.handleOnTap(context);
          },
          onSuffixTap: () {
            viewModel.handleOnSuffixTap(context);
          },
          validator: (value) {
            return viewModel.uploadInvoiceValidation();
          },
          isMandatory: true,
          controller: viewModel.uploadInvoiceController),
    );
  }

  Padding quantityReceivedField(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                Validations().numbericWithDotRegex)
          ],
          textInputType: TextInputType.number,
          hintText: StringConstants().quantityReceived,
          isMandatory: true,
          validator: (value) {
            return viewModel.quantityReceivedValidation();
          },
          controller: viewModel.quantityReceivedController),
    );
  }

  Padding tyreSourceDropdown(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonDropdownTextFormField(
        error: viewModel.tyreSourceDropdownError,
        onTap: () {
          viewModel.changetyreSourceDropdownValue(
            viewModel.tyreSourceDropdownValue,
          );
        },
        value: viewModel.tyreSourceDropdownValue,
        labelText: StringConstants().tyreSourceLabel,
        dropDownItem: viewModel.tyreSource,
        onChanged: (value) {
          viewModel.changetyreSourceDropdownValue(
            value,
          );
          viewModel.tyreSourceDropdownError = null;
        },
      ),
    );
  }

  Padding rawMaterialDropdown(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonDropdownTextFormField(
        error: viewModel.rawMaterialDropdownError,
        onTap: () {
          viewModel.changeRawMaterialDropdownValue(
            viewModel.tyreSourceDropdownValue,
          );
        },
        value: viewModel.rawMaterialDropdownValue,
        labelText: StringConstants().typeOfRawMaterial,
        dropDownItem: viewModel.typeOfRawMaterial,
        onChanged: (value) {
          viewModel.changeRawMaterialDropdownValue(
            value,
          );
          viewModel.rawMaterialDropdownError = null;
        },
      ),
    );
  }

  Padding addressOfWasteSupplierField(
      RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          hintText: StringConstants().addressOfWasteTyreSupplier,
          isMandatory: true,
          validator: (value) {
            return viewModel.valueValidation(viewModel.addressController);
          },
          controller: viewModel.addressController),
    );
  }

  Padding contactDetailsField(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          hintText: StringConstants().contactDetails,
          textInputType: TextInputType.number,
          isMandatory: true,
          validator: (value) {
            return viewModel.contactDetailsValidation();
          },
          controller: viewModel.sellerMobileController),
    );
  }

  Padding nameField(RecyclerProcurementAddDataViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CommonTextFormFieldWidget(
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          hintText: StringConstants().nameOfWasteTyreSupplier,
          textInputType: TextInputType.text,
          isMandatory: true,
          validator: (value) {
            return viewModel.nameValidation();
          },
          controller: viewModel.sellerNameController),
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
              ?.copyWith(color: AppColor().red),
        ),
      ),
    );
  }
}
