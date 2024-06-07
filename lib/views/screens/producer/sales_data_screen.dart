import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer/sales_data_viewmodel.dart';
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

class SalesDataScreen extends StatelessWidget {
  const SalesDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesDataViewModel>(
        onModelReady: (viewModel) async {
          viewModel.textFormListener();
          await viewModel.getProducerDataConstants(context);
        },
        viewModel: SalesDataViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              resizeToBottomInset: true,
              isLoading: viewModel.state == ViewState.busy,
              backgroundColor: AppColor().offWhite,
              appBar: CommonAppBar(
                title: viewModel.stringConstants.addSalesDataBtnLabel,
              ),
              body: formSection(context, viewModel),
              persistentFooterButtons: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor().white,
                  ),
                  child: CommonButtonWidget(
                    height: 50,
                    label: viewModel.stringConstants.submitBtnLabel,
                    color: AppColor().darkGreen,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColor().white),
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
                                    await viewModel.postProducerData(context);
                                  }
                                },
                              );
                            });
                      }
                    },
                  ),
                ),
              ]);
        });
  }

  CommonSingleChildScrollView formSection(
      BuildContext context, SalesDataViewModel viewModel) {
    return CommonSingleChildScrollView(
      controller: viewModel.scrollController,
      child: Form(
        key: viewModel.formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  error: viewModel.producerDropdownError,
                  onTap: () {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.producerType,
                        viewModel.producerDropdownValue);
                  },
                  labelText: viewModel.stringConstants.typeOfProducerLabel,
                  value: viewModel.producerDropdownValue,
                  dropDownItem: viewModel.producerList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.producerType, value);
                    viewModel.producerDropdownError = null;
                  },
                ),
              ),
              if (viewModel.producerError.isNotEmpty)
                showErrorMessage(context, viewModel.producerError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  error: viewModel.tyreDropdownError,
                  onTap: () {
                    viewModel.changeDropdownValue(SalesDataDropdown.typeOfTyre,
                        viewModel.tyreDropdownValue);
                  },
                  value: viewModel.tyreDropdownValue,
                  labelText: viewModel.stringConstants.typeOfTyreLabel,
                  dropDownItem: viewModel.tyreList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.typeOfTyre, value);
                    viewModel.tyreDropdownError = null;
                  },
                ),
              ),
              if (viewModel.tyreError.isNotEmpty)
                showErrorMessage(context, viewModel.tyreError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  error: viewModel.yearDropdownError,
                  onTap: () {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.financialYear,
                        viewModel.yearDropdownValue);
                  },
                  value: viewModel.yearDropdownValue,
                  labelText: viewModel.stringConstants.financialYearLabel,
                  dropDownItem: viewModel.financialYearList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.financialYear, value);
                    viewModel.yearDropdownError = null;
                  },
                ),
              ),
              if (viewModel.financialYearError.isNotEmpty)
                showErrorMessage(context, viewModel.financialYearError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  error: viewModel.monthDropdownError,
                  onTap: () {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.month, viewModel.monthDropdownValue);
                  },
                  value: viewModel.monthDropdownValue,
                  labelText: viewModel.stringConstants.chooseMonthLabel,
                  dropDownItem: viewModel.monthList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.month, value);
                    viewModel.monthDropdownError = null;
                  },
                ),
              ),
              if (viewModel.monthError.isNotEmpty)
                showErrorMessage(context, viewModel.monthError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.motorcycleLabel,
                    isMandatory: false,
                    controller: viewModel.motorcycleController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.passengerCarLabel,
                    isMandatory: false,
                    controller: viewModel.passengerCarController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.scooterLabel,
                    isMandatory: false,
                    controller: viewModel.scooterController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.truckLabel,
                    isMandatory: false,
                    controller: viewModel.truckController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.busLabel,
                    isMandatory: false,
                    controller: viewModel.busController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.lcvLabel,
                    isMandatory: false,
                    controller: viewModel.lcvController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.tRearLabel,
                    isMandatory: false,
                    controller: viewModel.tRearController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: viewModel.stringConstants.otherLabel,
                    isMandatory: false,
                    controller: viewModel.otherController),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: CommonTextFormFieldWidget(
                    validator: (value) {
                      return viewModel.totalValidation();
                    },
                    disabledBgColor: AppColor().white,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    isReadOnly: true,
                    hintText: viewModel.stringConstants.totalLabel,
                    isMandatory: false,
                    controller: viewModel.totalController),
              ),
              if (viewModel.totalError.isNotEmpty)
                showErrorMessage(context, viewModel.totalError),
            ],
          ),
        ),
      ),
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
              ?.copyWith(color: AppColor().red),
        ),
      ),
    );
  }
}
