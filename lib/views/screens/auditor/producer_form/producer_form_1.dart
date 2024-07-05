import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/views/widgets/app_components/auditor_form_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';
import '../../../../viewmodels/auditor/producer_form/producer_form_1_view_model.dart';
import '../../base_view.dart';

class ProducerForm1 extends StatefulWidget {
  const ProducerForm1({super.key});

  @override
  State<ProducerForm1> createState() => _ProducerForm1State();
}

class _ProducerForm1State extends State<ProducerForm1> {
  ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    return BaseView<ProducerForm1ViewModel>(
      onModelReady: (viewModel) {
        viewModel.initalizeGroupValues();
      },
      viewModel: ProducerForm1ViewModel(),
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTitleWidget(
                  label: viewModel.stringConstants.companyDetails.i18n()),
              AuditorFormTile(
                title: viewModel.stringConstants.companyNameAddress.i18n(),
                isMandatory: true,
                groupValue: viewModel.radioCompanyDetail,
                remarkController: viewModel.companyNameRemark,
                onChanged: (value) {
                  viewModel.radioCompanyDetail = value ?? '';
                  viewModel.updateUI();
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
              ),
              AuditorFormTile(
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
                onValidation: (value) {
                  return null;
                  // return viewModel.uploadInvoiceValidation();
                },
              ),
              AuditorFormTile(
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
                  viewModel.handleOnTap(
                      context,
                      AuditorProducerForm1.panOfCompany,
                      viewModel.panController,
                      viewModel.panFile);
                },
                onSuffixTap: () {
                  viewModel.handleOnSuffixTap(
                      context,
                      AuditorProducerForm1.panOfCompany,
                      viewModel.panController,
                      viewModel.panFile);
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
              ),
              AuditorFormTile(
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
                onValidation: (value) {
                  return null;
                  // return viewModel.uploadInvoiceValidation();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
