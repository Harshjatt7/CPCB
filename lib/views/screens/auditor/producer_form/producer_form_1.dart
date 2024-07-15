import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/auditor_form_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/forms/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import '../../../../viewmodels/auditor/producer_form/producer_forms_view_model.dart';

// ignore: must_be_immutable
class ProducerForm1 extends StatefulWidget {
  final bool? isSummaryScreen;
  const ProducerForm1({
    super.key,
    this.isSummaryScreen,
  });

  @override
  State<ProducerForm1> createState() => _ProducerForm1State();
}

class _ProducerForm1State extends State<ProducerForm1> {
  late ProducerFormsViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<ProducerFormsViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProducerFormsViewModel>(
      builder: (context, value, child) {
        return Stack(
        children: [
          widget.isSummaryScreen == true
              ? CommonSingleChildScrollView(child: viewReportView(viewModel))
              : CommonSingleChildScrollView(
                  child: fillFormView(viewModel, context)),
          Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: StepperButton(
                isLastStep: false,
                isSummaryScreen: false,
                onNextOrSubmit: () {
                  Provider.of<CommonStepperViewModel>(context, listen: false)
                      .onNextButton(context, "Producer");
                 
                },
              ))
        ],
      );
      }
    );
  }

  Widget fillFormView(ProducerFormsViewModel viewModel, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: viewModel.stringConstants.companyDetails),
          AuditorFormTile(
            title: viewModel.stringConstants.companyNameAddress.i18n(),
            isMandatory: true,
            groupValue: viewModel.radioCompanyDetail,
            remarkController: viewModel.companyNameRemark,
            onChanged: (value) {
              viewModel.radioCompanyDetail = value ?? '';
              viewModel.updateUI();
            },
            validator: (value) {
              return viewModel.validate(viewModel.companyNameRemark.text);
            },
          ),
          AuditorFormTile(
            title: viewModel.stringConstants.categoryOfProducer.i18n(),
            isMandatory: true,
            groupValue: viewModel.radioCategoryOfProducer,
            remarkController: viewModel.categoryOfProducerRemark,
            onChanged: (value) {
              viewModel.radioCategoryOfProducer = value ?? '';
              viewModel.updateUI();
            },
            validator: (value) {
              return viewModel
                  .validate(viewModel.categoryOfProducerRemark.text);
            },
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.gst.i18n(),
            isUpload: true,
            groupValue: viewModel.radioGst,
            remarkController: viewModel.gstRemark,
            uploadController: viewModel.gstController,
            filePath: viewModel.gstFilePath,
            onChanged: (value) {
              viewModel.radioGst = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.handleOnTap(context, AuditorProducerForm1.gst,
                  viewModel.gstController, viewModel.gstFile);
            },
            onSuffixTap: () {
              viewModel.handleOnSuffixTap(context, AuditorProducerForm1.gst,
                  viewModel.gstController, viewModel.gstFile);
            },
            validator: (value) {
              return viewModel.validate(viewModel.gstRemark.text);
            },
            uploadValidator: (value) {
              return viewModel
                  .uploadInvoiceValidation(viewModel.gstFileSizeModel);
            },
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.panOfCompany.i18n(),
            isUpload: true,
            groupValue: viewModel.radioPanOfCompany,
            remarkController: viewModel.panOfCompanyRemark,
            uploadController: viewModel.panController,
            filePath: viewModel.panFilePath,
            onChanged: (value) {
              viewModel.radioPanOfCompany = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.handleOnTap(context, AuditorProducerForm1.panOfCompany,
                  viewModel.panController, viewModel.panFile);
            },
            onSuffixTap: () {
              viewModel.handleOnSuffixTap(
                  context,
                  AuditorProducerForm1.panOfCompany,
                  viewModel.panController,
                  viewModel.panFile);
            },
            validator: (value) {
              return viewModel.validate(viewModel.panOfCompanyRemark.text);
            },
            uploadValidator: (value) {
              return viewModel
                  .uploadInvoiceValidation(viewModel.panFileSizeModel);
            },
          ),
          AuditorFormTile(
            title: viewModel.stringConstants.cin.i18n(),
            isUpload: true,
            groupValue: viewModel.radioCin,
            remarkController: viewModel.cinRemark,
            uploadController: viewModel.cinController,
            filePath: viewModel.cinFilePath,
            onChanged: (value) {
              viewModel.radioCin = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.handleOnTap(context, AuditorProducerForm1.cin,
                  viewModel.cinController, viewModel.cinFile);
            },
            onSuffixTap: () {
              viewModel.handleOnSuffixTap(context, AuditorProducerForm1.cin,
                  viewModel.cinController, viewModel.cinFile);
            },
            validator: (value) {
              return viewModel.validate(viewModel.cinRemark.text);
            },
            uploadValidator: (value) {
              return viewModel
                  .uploadInvoiceValidation(viewModel.cinFileSizeModel);
            },
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.iec.i18n(),
            isUpload: true,
            groupValue: viewModel.radioIec,
            remarkController: viewModel.iecRemark,
            uploadController: viewModel.iecController,
            filePath: viewModel.iecFilePath,
            onChanged: (value) {
              viewModel.radioIec = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.handleOnTap(context, AuditorProducerForm1.iec,
                  viewModel.iecController, viewModel.iecFile);
              viewModel.updateUI();
            },
            onSuffixTap: () {
              viewModel.handleOnSuffixTap(context, AuditorProducerForm1.iec,
                  viewModel.iecController, viewModel.iecFile);
            },
            validator: (value) {
              return viewModel.validate(viewModel.iecRemark.text);
            },
            uploadValidator: (value) {
              return viewModel
                  .uploadInvoiceValidation(viewModel.iecFileSizeModel);
            },
          ),
        ],
      ),
    );
  }

  Padding viewReportView(ProducerFormsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: viewModel.stringConstants.companyDetails),
          AuditorFormTile(
            title: viewModel.stringConstants.companyNameAddress.i18n(),
            isMandatory: true,
            groupValue: viewModel.radioCompanyDetail,
            remarkController: viewModel.companyNameRemark,
            isReadOnly: true,
          ),
          AuditorFormTile(
            title: viewModel.stringConstants.categoryOfProducer.i18n(),
            isMandatory: true,
            groupValue: viewModel.radioCategoryOfProducer,
            remarkController: viewModel.categoryOfProducerRemark,
            isReadOnly: true,
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.gst.i18n(),
            isUpload: true,
            groupValue: viewModel.radioGst,
            remarkController: viewModel.gstRemark,
            uploadController: viewModel.gstController,
            filePath: viewModel.gstFilePath,
            isReadOnly: true,
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.panOfCompany.i18n(),
            isUpload: true,
            groupValue: viewModel.radioPanOfCompany,
            remarkController: viewModel.panOfCompanyRemark,
            uploadController: viewModel.panController,
            filePath: viewModel.panFilePath,
            isReadOnly: true,
          ),
          AuditorFormTile(
            title: viewModel.stringConstants.cin.i18n(),
            isUpload: true,
            groupValue: viewModel.radioCin,
            remarkController: viewModel.cinRemark,
            uploadController: viewModel.cinController,
            filePath: viewModel.cinFilePath,
            isReadOnly: true,
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.iec.i18n(),
            isUpload: true,
            groupValue: viewModel.radioIec,
            remarkController: viewModel.iecRemark,
            uploadController: viewModel.iecController,
            filePath: viewModel.iecFilePath,
            isReadOnly: true,
          ),
        ],
      ),
    );
  }
}
