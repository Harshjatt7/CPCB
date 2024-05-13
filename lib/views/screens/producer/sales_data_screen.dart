import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer_viewmodels/producer_widget_viewmodel.dart';
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
    return BaseView<ProducerWidgetViewModel>(
        onModelReady: (viewModel) {},
        viewModel: ProducerWidgetViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              backgroundColor: AppColor().offWhite,
              appBar: const CommonAppBar(
                title: 'Add Sales Data',
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
                          error: viewModel.dropdownError,
                          onTap: () {
                            viewModel.changeDropdownValue(null);
                          },
                          labelText: 'Type of producer',
                          dropDownItem: const ['text1', 'text2'],
                          onChanged: (value) {
                            viewModel.changeDropdownValue(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonDropdownTextFormField(
                          error: viewModel.dropdownError,
                          onTap: () {
                            viewModel.changeDropdownValue(null);
                          },
                          labelText: 'Type of tyre',
                          dropDownItem: const ['text1', 'text2'],
                          onChanged: (value) {
                            viewModel.changeDropdownValue(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonDropdownTextFormField(
                          error: viewModel.dropdownError,
                          onTap: () {
                            viewModel.changeDropdownValue(null);
                          },
                          labelText: 'Financial year',
                          dropDownItem: const ['text1', 'text2'],
                          onChanged: (value) {
                            viewModel.changeDropdownValue(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonDropdownTextFormField(
                          error: viewModel.dropdownError,
                          onTap: () {
                            viewModel.changeDropdownValue(null);
                          },
                          labelText: 'Choose month',
                          dropDownItem: const ['text1', 'text2'],
                          onChanged: (value) {
                            viewModel.changeDropdownValue(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "Motorcycle",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "Passenger car",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "Scooter",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "Truck",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "Bus",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "LCV",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "T Rear",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: "Other",
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CommonTextFormFieldWidget(
                            hintText: "Total",
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
                    height: 50,
                    label: 'Submit',
                    color: AppColor().darkGreen18632E,
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
