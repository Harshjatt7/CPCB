import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/procurement_add_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProcurementAddDataScreen extends StatelessWidget {
  const ProcurementAddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProcurementAddDataViewModel>(
        viewModel: ProcurementAddDataViewModel(),
        onModelReady: (viewModel) {
          viewModel.addYear();
        },
        builder: (context, viewModel, child) {
          return CustomScaffold(
              isLoading: viewModel.state == ViewState.busy,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonDropdownTextFormField(
                            error: viewModel.yearDropdownError,
                            onTap: () {
                              viewModel.changeDropdownValue(
                                  viewModel.yearDropdownValue);
                            },
                            value: viewModel.yearDropdownValue,
                            labelText: StringConstants().financialYearLabel,
                            dropDownItem: viewModel.financialYearList,
                            onChanged: (value) {
                              viewModel.changeDropdownValue(value);
                              viewModel.yearDropdownError = null;
                            },
                          ),
                        ),
                        if (viewModel.financialYearError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.financialYearError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              hintText:
                                  StringConstants().nameOfWasteTyreSupplier,
                              isMandatory: true,
                              validator: (value) {
                                return viewModel.valueValidation(viewModel
                                    .nameOfWasteTyreSupplierController);
                              },
                              controller:
                                  viewModel.nameOfWasteTyreSupplierController),
                        ),
                        if (viewModel.supplierNameError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.supplierNameError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              hintText: StringConstants().contactDetails,
                              textInputType: TextInputType.number,
                              isMandatory: true,
                              validator: (value) {
                                return viewModel.contactDetailsValidation();
                              },
                              controller: viewModel.contactDetailsController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              textInputType: TextInputType.number,
                              hintText:
                                  StringConstants().supplierContactDetails,
                              isMandatory: true,
                              validator: (value) {
                                return viewModel
                                    .supplierContactDetailsValidation();
                              },
                              controller:
                                  viewModel.supplierContactDetailsController),
                        ),
                        if (viewModel.supplierContactError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.supplierContactError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              hintText:
                                  StringConstants().addressOfWasteTyreSupplier,
                              isMandatory: true,
                              validator: (value) {
                                return viewModel.valueValidation(
                                    viewModel.addressController);
                              },
                              controller: viewModel.addressController),
                        ),
                        if (viewModel.addressError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.addressError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              hintText: StringConstants().typeOfRawMaterial,
                              isMandatory: true,
                              validator: (value) {
                                return viewModel.valueValidation(
                                    viewModel.typeOfRawMaterialController);
                              },
                              controller:
                                  viewModel.typeOfRawMaterialController),
                        ),
                        if (viewModel.rawMaterialError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.rawMaterialError ?? ''),
                        Padding(
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
                        ),
                        if (viewModel.quantityReceivedError?.isNotEmpty ??
                            false)
                          showErrorMessage(
                              context, viewModel.quantityReceivedError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              isDocument:
                                  viewModel.filePath == null ? false : true,
                              disabledBgColor: AppColor().transparent,
                              isReadOnly: true,
                              hintText: StringConstants().uploadInvoice,
                              icon:
                                  viewModel.uploadInvoiceController.text.isEmpty
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
                        ),
                        if (viewModel.uploadInvoiceError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.uploadInvoiceError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputType: TextInputType.number,
                              hintText: StringConstants().invoiceNumber,
                              isMandatory: true,
                              validator: (value) {
                                return viewModel.valueValidation(
                                    viewModel.invoiceNumberController);
                              },
                              controller: viewModel.invoiceNumberController),
                        ),
                        if (viewModel.invoiceNumberError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.invoiceNumberError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15)
                              ],
                              hintText: StringConstants()
                                  .gstNumberOfWasteTyreSupplier,
                              validator: (value) {
                                return viewModel.gstNumberValidation();
                              },
                              isMandatory: true,
                              controller: viewModel.gstController),
                        ),
                        if (viewModel.gstNumberError?.isNotEmpty ?? false)
                          showErrorMessage(
                              context, viewModel.gstNumberError ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              isReadOnly: true,
                              disabledBgColor: AppColor().transparent,
                              hintText:
                                  StringConstants().dateOfPurchaseOfRawMaterial,
                              isMandatory: true,
                              onTap: () async {
                                viewModel.date =
                                    await datePicker(context, viewModel);
                                if (viewModel.date != null) {
                                  viewModel.dateTimeConvert();
                                }
                              },
                              icon: ImageConstants().calendar,
                              controller: viewModel.dateController),
                        ),
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
                    onPressed: () async {
                      viewModel.formValidation(context);
                      if (viewModel.formKey.currentState?.validate() ?? false) {
                        popUpMessage(context, viewModel);
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

  popUpMessage(BuildContext context, ProcurementAddDataViewModel viewModel) {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: AppColor().red,
          content: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor().white,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: CommonTextWidget(
                    MessageConstant().submitAlertTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Flexible(flex: 5, child: SizedBox()),
                      Flexible(
                        flex: 2,
                        child: CommonButtonWidget(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          label: StringConstants().no,
                          color: AppColor().white,
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: CommonButtonWidget(
                            label: StringConstants().yes,
                            onPressed: () {
                              Navigator.pop(ctx);
                              viewModel.postRequest(context);
                            },
                            color: AppColor().darkGreen,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColor().white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<DateTime?> datePicker(
      BuildContext context, ProcurementAddDataViewModel viewModel) {
    return showDatePicker(
      context: context,
      firstDate: viewModel.startDate,
      lastDate: DateTime.now(),
    );
  }
}
