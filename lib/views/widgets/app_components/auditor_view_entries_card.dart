import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../constants/image_constants.dart';

class AuditorViewEntriesCard extends StatelessWidget {
  final bool? isDetailProduct;
  final VoidCallback? onEditTap;
  final VoidCallback? onViewTap;
  final VoidCallback? onDownloadTap;
  final String? supplierName;
  final String? invoiceNo;
  final String? rawMaterial;
  final String? year;
  final String? salesInvoice;
  final String? quantity;
  final String? balance;
  const AuditorViewEntriesCard(
      {super.key,
      this.isDetailProduct = false,
      this.onEditTap,
      this.onViewTap,
      this.onDownloadTap,
      this.supplierName,
      this.invoiceNo,
      this.quantity,
      this.rawMaterial,
      this.salesInvoice,
      this.year,
      this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor().black20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(supplierName ?? "",
                  style: Theme.of(context).textTheme.displayMedium),
              if (isDetailProduct == false)
                InkWell(
                  onTap: onEditTap,
                  child: CommonImageWidget(
                      imageSource: ImageConstants().editIcon,
                      isNetworkImage: false),
                ),
              if (isDetailProduct == true)
                Row(
                  children: [
                    InkWell(
                      onTap: onViewTap,
                      child: CommonImageWidget(
                        imageSource: ImageConstants().viewEyes,
                        isNetworkImage: false,
                        imageColor: AppColor().darkGreen,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: onDownloadTap,
                      child: CommonImageWidget(
                        imageSource: ImageConstants().fileUpload,
                        isNetworkImage: false,
                        imageColor: AppColor().darkGreen,
                      ),
                    ),
                  ],
                )
            ],
          ),
          const SizedBox(height: 8),
          buildColumnData(context, label: "${StringConstants().invoiceNo.i18n()}: ", data: invoiceNo),
          const SizedBox(height: 8),
          buildColumnData(context,
              label: "${StringConstants().typeOfRawMaterial.i18n()}: ", data: rawMaterial),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(
              color: AppColor().black10,
            ),
          ),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: buildRowData(context, label: "${StringConstants().financialYearLabel.i18n()}: ", data: year)),
              Flexible(
                flex: 1,
                child: buildRowData(context,
                    label: isDetailProduct == true
                        ? "${StringConstants().salesInvoice.i18n()}: "
                        : "${StringConstants().quantity.i18n()}: ",
                    data: isDetailProduct == true ? salesInvoice : quantity),
              ),
              if (isDetailProduct == false)
                Flexible(
                    flex: 1,
                    child: buildRowData(context,
                        label: "${StringConstants().balance.i18n()}: ", data: balance)),
            ],
          )
        ],
      ),
    );
  }

  RichText buildRowData(BuildContext context, {String? label, String? data}) {
    return RichText(
      text: WidgetSpan(
        child: Row(
          children: [
            CommonTextWidget(label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColor().black40)),
            CommonTextWidget(
              data ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor().black40),
            ),
          ],
        ),
      ),
    );
  }

  RichText buildColumnData(BuildContext context,
      {String? label, String? data}) {
    return RichText(
      text: WidgetSpan(
        child: Row(
          children: [
            CommonTextWidget(
              label ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor().black50),
              useLocalization: false,
            ),
            CommonTextWidget(data ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColor().black70))
          ],
        ),
      ),
    );
  }
}
