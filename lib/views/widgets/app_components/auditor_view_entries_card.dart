import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AuditorViewEntriesCard extends StatelessWidget {
  final bool? isDetailProduct;
  final VoidCallback? onEditTap;
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
              InkWell(
                onTap: onEditTap,
                child: CommonImageWidget(
                    imageSource: ImageConstants().downloadApplicationIcon,
                    imageColor: AppColor().black,
                    height: 15,
                    width: 15,
                    isNetworkImage: false),
              ),
            ],
          ),
          const SizedBox(height: 8),
          buildColumnData(context,
              label: "${StringConstants().invoiceNo.i18n()}: ",
              data: invoiceNo),
          const SizedBox(height: 8),
          buildColumnData(context,
              label: "${StringConstants().typeOfRawMaterial.i18n()}: ",
              data: rawMaterial),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(
              color: AppColor().black10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 1,
                    child: buildRowData(context,
                        label: "${StringConstants().year.i18n()}: ",
                        data: year)),
                Flexible(
                  flex: 1,
                  child: buildRowData(context,
                      label: isDetailProduct == true
                          ? "${StringConstants().salesInvoice.i18n()}: "
                          : "${StringConstants().quantity.i18n()}: ",
                      data: isDetailProduct == true ? salesInvoice : quantity),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }

  RichText buildRowData(BuildContext context, {String? label, String? data}) {
    return RichText(
      text: WidgetSpan(
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
