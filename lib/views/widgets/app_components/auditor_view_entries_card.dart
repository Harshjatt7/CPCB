import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';

class AuditorViewEntriesCard extends StatelessWidget {
  const AuditorViewEntriesCard({super.key});

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
              CommonTextWidget("Name of Supplier",
                  style: Theme.of(context).textTheme.displayMedium),
              InkWell(
                onTap: () {},
                child: CommonImageWidget(
                    imageSource: ImageConstants().editIcon,
                    isNetworkImage: false),
              )
            ],
          ),
          const SizedBox(height: 8),
          buildColumnData(context, label: "Invoice No.", data: "0839232"),
          const SizedBox(height: 8),
          buildColumnData(context,
              label: "Type of raw material: ", data: "Tyres"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(
              color: AppColor().black10,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildRowData(context, label: "Year: ", data: "2023"),
              buildRowData(context, label: "Quantity: ", data: "2023"),
              buildRowData(context, label: "Balance: ", data: "2023"),
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
