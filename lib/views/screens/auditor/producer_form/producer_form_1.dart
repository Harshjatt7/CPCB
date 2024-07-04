import 'package:cpcb_tyre/views/widgets/app_components/auditor_form_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      onModelReady: (viewModel) {},
      viewModel: ProducerForm1ViewModel(),
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTitleWidget(
                  label: viewModel.stringConstants.companyDetails),
              AuditorFormTile(
                title: viewModel.stringConstants.companyNameAddress,
                isMandatory: true,
                groupValue: viewModel.groupValue,
                onChanged: (value) {
                  viewModel.groupValue = value ?? '';
                  viewModel.updateUI();
                },
              ),
              AuditorFormTile(
                  title: viewModel.stringConstants.categoryOfProducer,
                  isMandatory: true,
                  groupValue: viewModel.groupValue),
              AuditorFormTile(
                  title: viewModel.stringConstants.gst,
                  isUpload: true,
                  groupValue: viewModel.groupValue),
              AuditorFormTile(
                  title: viewModel.stringConstants.panOfCompany,
                  isUpload: true,
                  groupValue: viewModel.groupValue),
              AuditorFormTile(
                  title: viewModel.stringConstants.cin,
                  isUpload: true,
                  groupValue: viewModel.groupValue),
              AuditorFormTile(
                  title: viewModel.stringConstants.iec,
                  isUpload: true,
                  groupValue: viewModel.groupValue),
            ],
          ),
        );
      },
    );
  }
}
