import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonAdminDashboardHeading extends StatelessWidget {
  const CommonAdminDashboardHeading({super.key});

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
                  flex: 2,
                  child: CommonTextWidget(
                    'End Product',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor().black80),
                  )),
              Expanded(
                  flex: 1,
                  child: CommonTextWidget(
                    'Generated',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor().black80),
                  )),
              Expanded(
                  flex: 1,
                  child: CommonTextWidget(
                    'Transferred',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor().black80),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
