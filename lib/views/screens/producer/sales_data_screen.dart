import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer/sales_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SalesDataScreen extends StatelessWidget {
  const SalesDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesDataViewModel>(
        onModelReady: (viewModel) {
          viewModel.addYear();
          viewModel.textFormListener();
        },
        viewModel: SalesDataViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              backgroundColor: AppColor().offWhite,
              appBar: CommonAppBar(
                title: StringConstants().addSalesDataBtnLabel,
              ),
              body: formSection(viewModel),
              persistentFooterButtons: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor().white,
                  ),
                  child: CommonButtonWidget(
                    height: 50,
                    label: StringConstants().submitBtnLabel,
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

  CommonSingleChildScrollView formSection(SalesDataViewModel viewModel) {
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
                        SalesDataDropdown.producerType, null);
                  },
                  labelText: StringConstants().typeOfProducerLabel,
                  value: viewModel.producerDropdownValue,
                  dropDownItem: viewModel.producerCategoryList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.producerType, value);
                    viewModel.producerDropdownError = null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  error: viewModel.tyreDropdownError,
                  onTap: () {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.typeOfTyre, null);
                  },
                  value: viewModel.tyreDropdownValue,
                  labelText: StringConstants().typeOfTyreLabel,
                  dropDownItem: viewModel.typesOfTyreList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.typeOfTyre, value);
                    viewModel.tyreDropdownError = null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  error: viewModel.yearDropdownError,
                  onTap: () {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.financialYear, null);
                  },
                  value: viewModel.yearDropdownValue,
                  labelText: StringConstants().financialYearLabel,
                  dropDownItem: viewModel.financialYearList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.financialYear, value);
                    viewModel.yearDropdownError = null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  error: viewModel.monthDropdownError,
                  onTap: () {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.month, null);
                  },
                  value: viewModel.monthDropdownValue,
                  labelText: StringConstants().chooseMonthLabel,
                  dropDownItem: viewModel.monthList,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(
                        SalesDataDropdown.month, value);
                    viewModel.monthDropdownError = null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: StringConstants().motorcycleLabel,
                    isMandatory: false,
                    controller: viewModel.motorcycleController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: StringConstants().passengerCarLabel,
                    isMandatory: false,
                    controller: viewModel.passengerCarController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: StringConstants().scooterLabel,
                    isMandatory: false,
                    controller: viewModel.scooterController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: StringConstants().truckLabel,
                    isMandatory: false,
                    controller: viewModel.truckController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: StringConstants().busLabel,
                    isMandatory: false,
                    controller: viewModel.busController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: StringConstants().lcvLabel,
                    isMandatory: false,
                    controller: viewModel.lcvController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    hintText: StringConstants().tRearLabel,
                    isMandatory: false,
                    controller: viewModel.tRearController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    disabledBgColor: AppColor().white,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    isReadOnly: true,
                    hintText: StringConstants().totalLabel,
                    isMandatory: false,
                    controller: viewModel.totalController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
