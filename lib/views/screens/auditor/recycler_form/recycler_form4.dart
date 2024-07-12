import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_4_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';

class AuditorRecyclerForm4 extends StatelessWidget {
  AuditorRecyclerForm4({super.key, this.isSummaryScreen = false});
  final AppColor appColor = AppColor();
  final StringConstants stringConstants = StringConstants();
  final bool? isSummaryScreen;

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm4ViewModel>(
        onModelReady: (viewModel) {},
        viewModel: RecyclerForm4ViewModel(),
        builder: (context, viewModel, child) {
          return isSummaryScreen == false
              ? form4View(context, viewModel)
              : summaryForm4View(context, viewModel);
        });
  }

  Padding summaryForm4View(
      BuildContext context, RecyclerForm4ViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: stringConstants.verifyTheProduction),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CommonTextWidget(
              stringConstants.viewEntries,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: appColor.blue100,
                  decoration: TextDecoration.underline,
                  decorationColor: appColor.blue100),
            ),
          ),
          commonForm4Tiles(context,
              title: stringConstants.noOfInvoices,
              controller: viewModel.invoiceController,
              remarkController: viewModel.remakrsInvoiceController,
              groupValue: viewModel.radioInvoice,
              isMandatory: false,
              isSummaryScreen: isSummaryScreen),
          commonForm4Tiles(context,
              title: stringConstants.noOfBuyers,
              controller: viewModel.buyersController,
              remarkController: viewModel.remakrsBuyerController,
              groupValue: viewModel.radioBuyer,
              isMandatory: false,
              isSummaryScreen: isSummaryScreen)
        ],
      ),
    );
  }

  Padding form4View(BuildContext context, RecyclerForm4ViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: stringConstants.verifyTheProduction),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CommonTextWidget(
              stringConstants.viewEntries,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: appColor.blue100,
                  decoration: TextDecoration.underline,
                  decorationColor: appColor.blue100),
            ),
          ),
          commonForm4Tiles(
            context,
            title: stringConstants.noOfInvoices,
            controller: viewModel.invoiceController,
            remarkController: viewModel.remakrsInvoiceController,
            groupValue: viewModel.radioInvoice,
            onChanged: (value) {
              viewModel.radioInvoice = value ?? '';
              viewModel.updateUI();
            },
            validator: (value) {
              return viewModel.emptyValidation(viewModel.invoiceController);
            },
            remarkValidator: (value) {
              return viewModel
                  .emptyValidation(viewModel.remakrsInvoiceController);
            },
          ),
          commonForm4Tiles(
            context,
            title: stringConstants.noOfBuyers,
            controller: viewModel.buyersController,
            remarkController: viewModel.remakrsBuyerController,
            groupValue: viewModel.radioBuyer,
            onChanged: (value) {
              viewModel.radioBuyer = value ?? '';
              viewModel.updateUI();
            },
            validator: (value) {
              return viewModel.emptyValidation(viewModel.buyersController);
            },
            remarkValidator: (value) {
              return viewModel
                  .emptyValidation(viewModel.remakrsBuyerController);
            },
          )
        ],
      ),
    );
  }

  Column commonForm4Tiles(
    BuildContext context, {
    bool isMandatory = false,
    bool? isSummaryScreen = false,
    String? groupValue,
    void Function(String?)? onChanged,
    TextEditingController? controller,
    TextEditingController? remarkController,
    RecyclerForm4ViewModel? viewModel,
    String? Function(String?)? validator,
    String? Function(String?)? remarkValidator,
    String? title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonMandatoryTitle(
          title: title ?? '',
          isMandatory: true,
        ),
        CommonRadioButton(
          groupValue: groupValue ?? "",
          value1: stringConstants.notConfirmed,
          value2: stringConstants.confirmed,
          label1: stringConstants.notConfirmed,
          label2: stringConstants.confirmed,
          onChanged: onChanged,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CommonTextFormFieldWidget(
              isReadOnly: isSummaryScreen,
              bgColor: appColor.white,
              hintText: title ?? '',
              isMandatory: false,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType: TextInputType.number,
              validator: validator,
              controller: controller ?? TextEditingController()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: CommonTextFormFieldWidget(
              isReadOnly: isSummaryScreen,
              bgColor: appColor.white,
              hintText: stringConstants.remarks.i18n(),
              validator: remarkValidator,
              isMandatory: false,
              controller: remarkController ?? TextEditingController()),
        ),
      ],
    );
  }
}
