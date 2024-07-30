import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/store_key_constants.dart';
import 'package:cpcb_tyre/views/widgets/app_components/auditor_form_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/forms/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import '../../../../viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import '../../../widgets/components/common_text_widget.dart';

// ignore: must_be_immutable
class ProducerForm1 extends StatefulWidget {
  final bool? isSummaryScreen;
  final String? id;

  const ProducerForm1({super.key, this.isSummaryScreen = false, this.id});

  @override
  State<ProducerForm1> createState() => _ProducerForm1State();
}

class _ProducerForm1State extends State<ProducerForm1> {
  late ProducerFormsViewModel viewModel;
  final storeKeyConstants = StoreKeyConstants();
  @override
  void initState() {
    viewModel = Provider.of<ProducerFormsViewModel>(context, listen: false);
    viewModel.initializeForm1TextEditingControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProducerFormsViewModel>(builder: (context, value, child) {
      return Stack(
        children: [
          Opacity(
            opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
            child: widget.isSummaryScreen == true
                ? CommonSingleChildScrollView(child: viewReportView(viewModel))
                : CommonSingleChildScrollView(
                    child: fillFormView(viewModel, context)),
          ),
          if (viewModel.state == ViewState.busy)
            Center(
              child: CircularProgressIndicator(
                color: viewModel.appColor.black,
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
                    ? viewModel.onNextButton(context, widget.id ?? "")
                    : await viewModel.postForm1Data(context, id: widget.id);
              },
              onSavedDraft: () async {
                await viewModel.postForm1Data(context,
                    id: widget.id, saveAsDraft: storeKeyConstants.saveAsDraft);
              },
            ),
          ),
        ],
      );
    });
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
            disableController: viewModel.disabledCompanyNameRemark,
            isMandatory: true,
            groupValue: viewModel.radioCompanyDetail,
            remarkController: viewModel.companyNameRemark,
            onChanged: (value) {
              viewModel.radioCompanyDetail = value ?? '';
              viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel.validate(viewModel.companyNameRemark.text);
            // },
          ),
          if (viewModel.companyNameRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.companyNameRemarkError),
          AuditorFormTile(
            title: viewModel.stringConstants.categoryOfProducer.i18n(),
            disableController: viewModel.disabledCategoryOfProducer,
            isMandatory: true,
            groupValue: viewModel.radioCategoryOfProducer,
            remarkController: viewModel.categoryOfProducerRemark,
            onChanged: (value) {
              viewModel.radioCategoryOfProducer = value ?? '';
              viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel
            //       .validate(viewModel.categoryOfProducerRemark.text);
            // },
          ),
          if (viewModel.categoryOfProducerRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.categoryOfProducerRemarkError),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.gst.i18n(),
            disableController: viewModel.disabledGst,
            isUpload: true,
            groupValue: viewModel.radioGst,
            remarkController: viewModel.gstRemark,
            uploadController: viewModel.gstFileName,
            isUploadReadOnly: true,
            filePath: viewModel.gstFilePath,
            onChanged: (value) {
              viewModel.radioGst = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.gstApiFilePath ?? "");
              // viewModel.handleOnTap(
              //     context, viewModel.gstFileName.text, viewModel.gstFilePath);
            },
            // validator: (value) {
            //   return viewModel.validate(viewModel.gstRemark.text);
            // },
          ),
          if (viewModel.gstRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.gstRemarkError),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.panOfCompany.i18n(),
            disableController: viewModel.disabledPan,
            isUpload: true,
            groupValue: viewModel.radioPanOfCompany,
            remarkController: viewModel.panOfCompanyRemark,
            uploadController: viewModel.panFileName,
            filePath: viewModel.panFilePath,
            isUploadReadOnly: true,
            onChanged: (value) {
              viewModel.radioPanOfCompany = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.panApiFilePath ?? "");
              // viewModel.handleOnTap(
              //     context, viewModel.panFileName.text, viewModel.panFilePath);
            },
            // validator: (value) {
            //   return viewModel.validate(viewModel.panOfCompanyRemark.text);
            // },
          ),
          if (viewModel.panOfCompanyRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.panOfCompanyRemarkError),
          AuditorFormTile(
            title: viewModel.stringConstants.cin.i18n(),
            disableController: viewModel.disabledCin,
            isUpload: true,
            groupValue: viewModel.radioCin,
            remarkController: viewModel.cinRemark,
            uploadController: viewModel.cinFileName,
            filePath: viewModel.cinFilePath,
            isUploadReadOnly: true,
            onChanged: (value) {
              viewModel.radioCin = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.cinApiFilePath ?? "");
              // viewModel.handleOnTap(
              //     context, viewModel.cinFileName.text, viewModel.cinFilePath);
            },
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.iec.i18n(),
            disableController: viewModel.disabledIec,
            isUpload: true,
            groupValue: viewModel.radioIec,
            remarkController: viewModel.iecRemark,
            uploadController: viewModel.iecFileName,
            filePath: viewModel.iecFilePath,
            isUploadReadOnly: true,
            onChanged: (value) {
              viewModel.radioIec = value ?? '';
              viewModel.updateUI();
            },
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.iecApiFilePath ?? "");
              // viewModel.handleOnTap(
              //     context, viewModel.iecFileName.text, viewModel.iecFilePath);
              // viewModel.updateUI();
            },
            // validator: (value) {
            //   return viewModel.validate(viewModel.iecRemark.text);
            // },
          ),
          if (viewModel.iecRemarkError.isNotEmpty)
            showErrorMessage(context, viewModel.iecRemarkError),
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
            disableController: viewModel.disabledCompanyNameRemark,
            remarkController: viewModel.companyNameRemark,
            isReadOnly: true,
          ),
          AuditorFormTile(
            title: viewModel.stringConstants.categoryOfProducer.i18n(),
            isMandatory: true,
            disableController: viewModel.disabledCategoryOfProducer,
            groupValue: viewModel.radioCategoryOfProducer,
            remarkController: viewModel.categoryOfProducerRemark,
            isReadOnly: true,
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.gst.i18n(),
            isUpload: true,
            disableController: viewModel.disabledGst,
            groupValue: viewModel.radioGst,
            remarkController: viewModel.gstRemark,
            uploadController: viewModel.gstFileName,
            filePath: viewModel.gstFilePath,
            isReadOnly: true,
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.gstApiFilePath ?? "");
            },
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.panOfCompany.i18n(),
            isUpload: true,
            disableController: viewModel.disabledPan,
            groupValue: viewModel.radioPanOfCompany,
            remarkController: viewModel.panOfCompanyRemark,
            uploadController: viewModel.panFileName,
            filePath: viewModel.panFilePath,
            isReadOnly: true,
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.panApiFilePath ?? "");
            },
          ),
          AuditorFormTile(
            title: viewModel.stringConstants.cin.i18n(),
            isUpload: true,
            groupValue: viewModel.radioCin,
            disableController: viewModel.disabledCin,
            remarkController: viewModel.cinRemark,
            uploadController: viewModel.cinFileName,
            filePath: viewModel.cinFilePath,
            isReadOnly: true,
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.cinApiFilePath ?? "");
            },
          ),
          AuditorFormTile(
            isMandatory: true,
            title: viewModel.stringConstants.iec.i18n(),
            isUpload: true,
            disableController: viewModel.disabledIec,
            groupValue: viewModel.radioIec,
            remarkController: viewModel.iecRemark,
            uploadController: viewModel.iecFileName,
            filePath: viewModel.iecFilePath,
            isReadOnly: true,
            onTap: () {
              viewModel.getViewEntriesFile(
                  context, viewModel.producerForm1Data?.iecFilePath ?? "");
            },
          ),
        ],
      ),
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
              ?.copyWith(color: viewModel.appColor.red),
        ),
      ),
    );
  }
}
