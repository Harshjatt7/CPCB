import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form3_reponse_model.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../constants/image_constants.dart';
import '../../../widgets/app_components/auditor_view_entries_card.dart';
import '../../../widgets/app_components/common_title_bar.dart';
import '../../../widgets/components/common_appbar.dart';

class RecyclerProcurementList extends StatelessWidget {
  const RecyclerProcurementList({super.key, required this.procurementData});
  final List<ProcurementDatum>? procurementData;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
              Row(
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
                  CommonTitleBar(title: "Procurement List"),
                ],
              ),
            ],
          ),
        ),
      ),
      body: procurmentListView(procurementData: procurementData),
    );
  }

  CommonSingleChildScrollView procurmentListView(
      {List<ProcurementDatum>? procurementData}) {
    return CommonSingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: List.generate(procurementData?.length ?? 0, (index) {
            final data = procurementData?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AuditorViewEntriesCard(
                supplierName: data?.sellerName ?? '',
                invoiceNo: data?.invoiceNumber ?? '',
                rawMaterial: data?.rawMaterial ?? '',
                year: data?.financeYear ?? '',
                quantity: data?.purchasedQuantity ?? '',
                balance: data?.openingBalance ?? '',
              ),
            );
          }),
        ),
      ),
    );
  }
}
