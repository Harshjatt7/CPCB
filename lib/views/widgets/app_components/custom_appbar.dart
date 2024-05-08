import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String image;
  final String name;
  final String designation;

  /// [CustomAppBar] will be used as the common appbar in this project.
  ///
  /// [image] is required field for avatar image.
  ///
  /// [name] is required field for name
  ///
  /// [designation] is required field for designation
  ///

  const CustomAppBar(
      {super.key,
      required this.image,
      required this.designation,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Container(
            height: 60,
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor().blackCCCCCC, width: 1.5)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
              child: CommonImageWidget(
                  fit: BoxFit.contain,
                  imageSource: image,
                  isNetworkImage: false),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: CommonTextWidget(name,
                  style: Theme.of(context).textTheme.bodyLarge!),
            ),
            CommonTextWidget(designation,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColor().appBarSubTitleText,
                    )),
          ],
        )
      ],
    ));
  }
}
