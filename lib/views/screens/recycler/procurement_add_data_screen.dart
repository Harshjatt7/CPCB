import 'package:cpcb_tyre/constants/image_constants.dart';
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
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecyclerProcurementAddDataScreen extends StatelessWidget {
  const RecyclerProcurementAddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProcurementAddDataViewModel>(
        viewModel: ProcurementAddDataViewModel(),
        onModelReady: (viewModel) {
          viewModel.addYear();
        },
        builder: (context, viewModel, child) {
          return CustomScaffold(
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
                                return viewModel.contactDetailsValidation();
                              },
                              controller:
                                  viewModel.supplierContactDetailsController),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              onChanged: (value) {
                                viewModel.onChange();
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              textInputType: TextInputType.datetime,
                              hintText:
                                  StringConstants().dateOfPurchaseOfRawMaterial,
                              isMandatory: true,
                              validator: (value) {
                                return viewModel.dateValidation();
                              },
                              icon: ImageConstants().calendar,
                              controller: viewModel.dateController),
                        ),
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
                      viewModel.formValidation(context);
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
}
