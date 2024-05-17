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
import 'package:flutter/services.dart';

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
              body: formSection(viewModel),
              persistentFooterButtons: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor().white,
                  ),
                  child: CommonButtonWidget(
                    onPressed: () {
                      viewModel.changeDropdownValue(null);
                      viewModel.formValidation();
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

  CommonSingleChildScrollView formSection(RetreadedAddDataViewModel viewModel) {
    return CommonSingleChildScrollView(
      child: Form(
        key: viewModel.formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonDropdownTextFormField(
                  labelText: StringConstants().financialYearLabel,
                  dropDownItem: viewModel.financialYearList,
                  error: viewModel.yearDropdownError,
                  value: viewModel.yearDropdownValue,
                  onTap: () {
                    viewModel.changeDropdownValue(viewModel.yearDropdownValue);
                  },
                  onChanged: (value) {
                    viewModel.changeDropdownValue(value);
                    viewModel.yearDropdownError = null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().nameOfWasteTyreSupplier,
                    isMandatory: false,
                    controller: viewModel.nameOfWasteTyreSupplierController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().contactDetails,
                    isMandatory: false,
                    controller: viewModel.contactDetailsController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().addressOfWasteTyreSupplier,
                    isMandatory: false,
                    controller: viewModel.addressController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().typeOfRawMaterial,
                    isMandatory: true,
                    controller: viewModel.typeOfRawMaterialController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    hintText: StringConstants().gstNumberOfWasteTyreSupplier,
                    validator: (value) {
                      return viewModel.gstNumberValidation();
                    },
                    isMandatory: true,
                    controller: viewModel.gstController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: StringConstants().quantityProcessed,
                    isMandatory: true,
                    validator: (value) {
                      return viewModel.quantityProcessedValidation();
                    },
                    controller: viewModel.quantityProcessedController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: StringConstants().quantityProduced,
                    validator: (value) {
                      return viewModel.quantityProducedValidation();
                    },
                    isMandatory: true,
                    controller: viewModel.quantityProducedController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: StringConstants().quantityOfWasteGenerated,
                    isMandatory: true,
                    validator: (value) {
                      return viewModel.quantityOfWasteGeneratedValidation();
                    },
                    controller: viewModel.quantityOfWasteGeneratedController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: StringConstants().retreadedDate,
                    isMandatory: true,
                    onChanged: (value) {
                      viewModel.onDateChange();
                    },
                    validator: (value) {
                      return viewModel.dateValidation();
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    textInputType: TextInputType.datetime,
                    icon: ImageConstants().calendar,
                    controller: viewModel.dateController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
