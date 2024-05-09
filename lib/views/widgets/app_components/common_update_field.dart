import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:flutter/material.dart';

class CommonDocumentField extends StatelessWidget {
  final VoidCallback? onTap;
  final String? fileName;
  const CommonDocumentField({super.key, required this.onTap, this.fileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColor().greyD3D3D3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: fileName ?? "File",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColor().grey919191)),
                TextSpan(
                    text: " *",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColor().redFF3333)),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: CommonImageWidget(
              imageSource: ImageConstants().fileUpload,
              isNetworkImage: false,
            ),
          ),
        ],
      ),
    );
  }
}
