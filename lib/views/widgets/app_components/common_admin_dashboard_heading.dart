import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonAdminDashboardHeading extends StatelessWidget {
  final AppColor appColor=AppColor();
   CommonAdminDashboardHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: CommonTextWidget(
                    'End Product',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: appColor.black80),
                  )),
              Flexible(
                  flex: 2,
                  child: CommonTextWidget(
                    'Generated',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: appColor.black80),
                  )),
              Flexible(
                  flex: 2,
                  child: CommonTextWidget(
                    'Transferred',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: appColor.black80),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
