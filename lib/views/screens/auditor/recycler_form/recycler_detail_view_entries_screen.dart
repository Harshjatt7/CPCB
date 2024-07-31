import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form4_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../constants/image_constants.dart';
import '../../../widgets/app_components/auditor_view_entries_card.dart';
import '../../../widgets/components/common_appbar.dart';

class RecyclerDetailScreen extends StatelessWidget {
  const RecyclerDetailScreen({super.key, required this.viewModel});
  final RecyclerFormViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isLoading: viewModel?.state == ViewState.busy,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppBar(
                isIconBar: true,
                showNotificationIcon: false,
                image: ImageConstants().avatar,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor().black10,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: CommonImageWidget(
                            imageSource: ImageConstants().arrowBack,
                            isNetworkImage: false),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: CommonTextWidget(
                            "Details on End Products sold in the market",
                            style: Theme.of(context).textTheme.labelLarge))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: detailViewEntries(context,
          eprData: viewModel?.eprData, viewModel: viewModel),
    );
  }

  CommonSingleChildScrollView detailViewEntries(BuildContext context,
      {List<EprDatum>? eprData, RecyclerFormViewModel? viewModel}) {
    return CommonSingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: List.generate(eprData?.length ?? 0, (index) {
            final data = eprData?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AuditorViewEntriesCard(
                isDetailProduct: true,
                supplierName: data?.name ?? '',
                invoiceNo: data?.invoiceNumber ?? '',
                rawMaterial: data?.buyerAddress ?? '',
                year: data?.financeYear ?? '',
                salesInvoice: data?.invoiceAmout ?? '',
                onDownloadTap: () async {
                  await viewModel?.getViewEntriesFile(
                      context, data?.invoiceLinkApi ?? '');
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
