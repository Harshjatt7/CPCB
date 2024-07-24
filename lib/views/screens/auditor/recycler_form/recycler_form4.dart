import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/forms/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class AuditorRecyclerForm4 extends StatefulWidget {
  final bool? isSummaryScreen;
  final bool isRetreader;
  final String? id;
  final String? userType;
  const AuditorRecyclerForm4(
      {super.key,
      this.isSummaryScreen = false,
      this.id,
      this.isRetreader = false,
      this.userType});

  @override
  State<AuditorRecyclerForm4> createState() => _AuditorRecyclerForm4State();
}

class _AuditorRecyclerForm4State extends State<AuditorRecyclerForm4> {
  final AppColor appColor = AppColor();
  final StringConstants stringConstants = StringConstants();
  ScrollController? controller;
  late RecyclerFormViewModel viewModel;
  @override
  void initState() {
    viewModel = Provider.of<RecyclerFormViewModel>(context, listen: false);
    viewModel.getRecycler4Data(context,
        isRetreader: widget.isRetreader, userId: widget.id ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecyclerFormViewModel>(
      builder: (context, value, child) {
        return Stack(
          children: [
            Opacity(
              opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
              child: widget.isSummaryScreen == true
                  ? CommonSingleChildScrollView(
                      child: summaryForm4View(context, viewModel))
                  : CommonSingleChildScrollView(
                      child: form4View(context, viewModel)),
            ),
            if (viewModel.state == ViewState.busy)
              Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(
                    color: appColor.black,
                  ),
                ),
              ),
            Positioned(
                bottom: 0,
                left: 10,
                right: 10,
                child: StepperButton(
                  isLastStep: false,
                  isSummaryScreen: widget.isSummaryScreen,
                  onNextOrSubmit: () async {
                    widget.isSummaryScreen == true
                        ? viewModel.onNextButton(context)
                        : await viewModel.postForm4Data(context,
                            submit: '',
                            isRetreader: widget.userType == "Retreader",
                            userId: widget.id ?? '');
                  },
                  onSavedDraft: () async {
                    await viewModel.postForm4Data(context,
                        isRetreader: widget.userType == "Retreader",
                        userId: widget.id ?? '');
                  },
                ))
          ],
        );
      },
    );
  }

  Widget summaryForm4View(
      BuildContext context, RecyclerFormViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 150),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: stringConstants.verifyTheProduction),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.auditorRecyclerDetailScreen,
                  arguments: viewModel.eprData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CommonTextWidget(
                stringConstants.viewEntries,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: appColor.blue100,
                    decoration: TextDecoration.underline,
                    decorationColor: appColor.blue100),
              ),
            ),
          ),
          commonForm4Tiles(context,
              title: stringConstants.noOfInvoices,
              controller: viewModel.invoiceController,
              remarkController: viewModel.remakrsInvoiceController,
              groupValue: viewModel.radioInvoice,
              isMandatory: false,
              isSummaryScreen: widget.isSummaryScreen),
          commonForm4Tiles(context,
              title: stringConstants.noOfBuyers,
              controller: viewModel.buyersController,
              remarkController: viewModel.remakrsBuyerController,
              groupValue: viewModel.radioBuyer,
              isMandatory: false,
              isSummaryScreen: widget.isSummaryScreen)
        ],
      ),
    );
  }

  Widget form4View(BuildContext context, RecyclerFormViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 150),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: stringConstants.verifyTheProduction),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.auditorRecyclerDetailScreen,
                  arguments: viewModel.eprData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CommonTextWidget(
                stringConstants.viewEntries,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: appColor.blue100,
                    decoration: TextDecoration.underline,
                    decorationColor: appColor.blue100),
              ),
            ),
          ),
          commonForm4Tiles(
            context,
            title: stringConstants.noOfInvoices,
            controller: viewModel.invoiceController,
            remarkController: viewModel.remakrsInvoiceController,
            groupValue: viewModel.radioInvoice,
            notVerifiedError:
                viewModel.invoiceAdditionalDataNumberOfSuppliersContactedError,
            remarkError: viewModel.invoiceAuditRemarkError,
            radioError: viewModel.invoiceAuditConfirmedStatusError,
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
            notVerifiedError:
                viewModel.buyersAdditionalDataNumberOfBuyersContactedError,
            remarkError: viewModel.buyersAuditRemarkError,
            radioError: viewModel.buyersAuditConfirmedStatusError,
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

  Column commonForm4Tiles(BuildContext context,
      {bool isMandatory = false,
      bool? isSummaryScreen = false,
      String? groupValue,
      void Function(String?)? onChanged,
      TextEditingController? controller,
      TextEditingController? remarkController,
      RecyclerFormViewModel? viewModel,
      String? Function(String?)? validator,
      String? Function(String?)? remarkValidator,
      String? title,
      String? remarkError,
      String? radioError,
      String? notVerifiedError}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonMandatoryTitle(
          title: title ?? '',
          isMandatory: true,
        ),
        CommonRadioButton(
          groupValue: groupValue ?? "",
          value1: stringConstants.radioValue1,
          value2: stringConstants.radioValue2,
          label1: stringConstants.notConfirmed,
          label2: stringConstants.confirmed,
          onChanged: onChanged,
        ),
        if (radioError != null) showErrorMessage(context, radioError),
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
        if (notVerifiedError != null)
          showErrorMessage(context, notVerifiedError),
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
        if (remarkError != null) showErrorMessage(context, remarkError),
      ],
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
              ?.copyWith(color: appColor.red),
        ),
      ),
    );
  }
}
