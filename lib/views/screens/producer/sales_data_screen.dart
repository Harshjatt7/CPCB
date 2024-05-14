import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/key_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer_viewmodels/producer_widget_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SalesDataScreen extends StatelessWidget {
  const SalesDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProducerWidgetViewModel>(
        onModelReady: (viewModel) {},
        viewModel: ProducerWidgetViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              backgroundColor: AppColor().offWhite,
              appBar: CommonAppBar(
                title: StringConstants().addSalesDataBtnLabel,
              ),
              body: CommonSingleChildScrollView(
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
                                KeyConstants().producer,
                                viewModel.changeDropdown);
                          },
                          labelText: StringConstants().typeOfProducerLabel,
                          dropDownItem: const ['text1', 'text2'],
                          onChanged: (value) {
                            viewModel.changeDropdownValue("producer", value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonDropdownTextFormField(
                          error: viewModel.tyreDropdownError,
                          onTap: () {
                            viewModel.changeDropdownValue(
                                "tyre", viewModel.changeDropdown);
                          },
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
                            viewModel.changeDropdownValue(
                                "year", viewModel.changeDropdown);
                          },
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
                            viewModel.changeDropdownValue(
                                "month", viewModel.changeDropdown);
                          },
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
                            hintText: StringConstants().motorcycleLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().passengerCarLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().scooterLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().truckLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().busLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().lcvLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().tRearLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().otherLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().totalLabel,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                    ],
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
                      popUpMessage(context);
                    },
                    height: 50,
                    label: 'Submit',
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

  popUpMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                      MessageConstant().salesDataSubmitAlertTitle,
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
                            label: "No",
                            color: AppColor().white,
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: CommonButtonWidget(
                              label: "Yes",
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
            ));
      },
    );
  }
}
