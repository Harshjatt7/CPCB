import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/retrader_viewmodels/procurement_add_data_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_upload_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProcurementAddDataPage extends StatelessWidget {
  const ProcurementAddDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProcurementAddDataViewModel>(
        viewModel: ProcurementAddDataViewModel(),
        onModelReady: (viewModel) {},
        builder: (context, viewModel, child) {
          return CustomScaffold(
              appBar: CommonAppBar(
                title: StringConstants().addProcurement,
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
                            hintText: StringConstants().supplierContactDetails,
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
                            hintText: StringConstants().quantityReceived,
                            isMandatory: true,
                            controller: TextEditingController()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonDocumentField(
                            onTap: () {},
                            label: StringConstants().uploadInvoice),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonTextFormFieldWidget(
                            hintText: StringConstants().invoiceNumber,
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
                            hintText:
                                StringConstants().dateOfPurchaseOfRawMaterial,
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
