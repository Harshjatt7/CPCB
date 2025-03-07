import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_environment_tile.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerAnnualReturnWidget extends StatelessWidget {
  ProducerAnnualReturnWidget(
      {super.key,
      required this.title,
      required this.date,
      required this.status,
      required this.fillingDate});
  final String title;
  final String date;
  final String status;
  final String fillingDate;
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor=AppColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: appColor.black10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: CommonTextWidget(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Divider(
            color: appColor.black10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: CommonImageWidget(
                        imageSource: imageConstants.document,
                        isNetworkImage: false,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Column(children: [
                          ProducerEnvironmentTile(
                              title: "DueDate",
                              subtitle: date,
                              image: imageConstants.calendar),
                          const SizedBox(
                            height: 12,
                          ),
                          ProducerEnvironmentTile(
                            title: "Current Status",
                            subtitle: status,
                            image: imageConstants.environmentInfo,
                            subtitleColor: appColor.orange,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ProducerEnvironmentTile(
                            title: "Date of Annual Return Filling",
                            subtitle: fillingDate,
                            image: imageConstants.calendar,
                          ),
                        ]),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
