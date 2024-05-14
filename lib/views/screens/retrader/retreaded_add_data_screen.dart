import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/retreaded_add_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class RetreadedAddDataScreen extends StatelessWidget {
  const RetreadedAddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RetreadedAddDataViewModel>(
        onModelReady: (viewModel) {},
        viewModel: RetreadedAddDataViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              appBar: CommonAppBar(
                title: StringConstants().addRetreadedData,
              ),
              body: CommonSingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonDropdownTextFormField(
                          labelText: StringConstants().financialYearLabel,
                          dropDownItem: const ["Text1", "Text2"],
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().nameOfWasteTyreSupplier,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().contactDetails,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText:
                                StringConstants().addressOfWasteTyreSupplier,
                            isMandatory: false,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().typeOfRawMaterial,
                            isMandatory: true,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText:
                                StringConstants().gstNumberOfWasteTyreSupplier,
                            isMandatory: true,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().quantityProcessed,
                            isMandatory: true,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().quantityProduced,
                            isMandatory: true,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText:
                                StringConstants().quantityOfWasteGenerated,
                            isMandatory: true,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().retreadedDate,
                            isMandatory: true,
                            icon: ImageConstants().calendar,
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
                    label: StringConstants().submitBtnLable,
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
