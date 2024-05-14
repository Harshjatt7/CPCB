import 'package:cpcb_tyre/constants/key_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer_viewmodels/sales_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SalesDataScreen extends StatelessWidget {
  const SalesDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesDataViewModel>(
        onModelReady: (viewModel) {
          viewModel.textFormListener();
        },
        viewModel: SalesDataViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              backgroundColor: AppColor().offWhite,
              appBar: CommonAppBar(
                title: StringConstants().addSalesDataBtnLabel,
              ),
              body: CommonSingleChildScrollView(
                controller: viewModel.scrollController,
                child: Form(
                  key: viewModel.formKey,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonDropdownTextFormField(
                            error: viewModel.producerDropdownError,
                            onTap: () {
                              viewModel.changeDropdownValue(
                                  KeyConstants().producer, null);
                            },
                            labelText: StringConstants().typeOfProducerLabel,
                            value: viewModel.producerDropdownValue,
                            dropDownItem: const ['text1', 'text2'],
                            onChanged: (value) {
                              viewModel.changeDropdownValue("producer", value);
                              viewModel.producerDropdownError = null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonDropdownTextFormField(
                            error: viewModel.tyreDropdownError,
                            onTap: () {
                              viewModel.changeDropdownValue("tyre", null);
                            },
                            value: viewModel.tyreDropdownValue,
                            labelText: StringConstants().typeOfTyreLabel,
                            dropDownItem: const ['text1', 'text2'],
                            onChanged: (value) {
                              viewModel.changeDropdownValue("tyre", value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonDropdownTextFormField(
                            error: viewModel.yearDropdownError,
                            onTap: () {
                              viewModel.changeDropdownValue("year", null);
                            },
                            value: viewModel.yearDropdownValue,
                            labelText: StringConstants().financialYearLabel,
                            dropDownItem: const ['text1', 'text2'],
                            onChanged: (value) {
                              viewModel.changeDropdownValue("year", value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonDropdownTextFormField(
                            error: viewModel.monthDropdownError,
                            onTap: () {
                              viewModel.changeDropdownValue("month", null);
                            },
                            value: viewModel.monthDropdownValue,
                            labelText: StringConstants().chooseMonthLabel,
                            dropDownItem: const ['text1', 'text2'],
                            onChanged: (value) {
                              viewModel.changeDropdownValue("month", value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().motorcycleLabel,
                              isMandatory: false,
                              controller: viewModel.motorcycleController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().passengerCarLabel,
                              isMandatory: false,
                              controller: viewModel.passengerCarController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().scooterLabel,
                              isMandatory: false,
                              controller: viewModel.scooterController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().truckLabel,
                              isMandatory: false,
                              controller: viewModel.truckController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().busLabel,
                              isMandatory: false,
                              controller: viewModel.busController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().lcvLabel,
                              isMandatory: false,
                              controller: viewModel.lcvController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().tRearLabel,
                              isMandatory: false,
                              controller: viewModel.tRearController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants().otherLabel,
                              isMandatory: false,
                              controller: viewModel.otherController),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          child: CommonTextFormFieldWidget(
                              validator: (value) {
                                return viewModel.totalValidation();
                              },
                              isClear: viewModel.isClear,
                              isReadOnly: true,
                              hintText: StringConstants().totalLabel,
                              isMandatory: false,
                              controller: viewModel.totalController),
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
                    height: 50,
                    label: StringConstants().submitBtnLable,
                    color: AppColor().darkGreen,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColor().white),
                    onPressed: () {
                      viewModel.dropDownValidation();
                      viewModel.formValidation();
                    },
                  ),
                ),
              ]);
        });
  }
}
