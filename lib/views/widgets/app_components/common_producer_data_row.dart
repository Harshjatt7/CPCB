import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/response/auditor/producer/producer_form_2_response_model.dart';

class CommonProducerDataRow extends StatelessWidget {
  const CommonProducerDataRow(
      {super.key, required this.demoModel, this.onTap, required this.isOdd});
  final Producers? demoModel;
  final void Function()? onTap;
  final bool isOdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isOdd == true ? AppColor().white : AppColor().grey15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
              child: CommonTextWidget(
                demoModel?.typeOfTyreManufacture ?? '',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: GestureDetector(
                onTap: onTap,
                child: CommonTextWidget(
                  demoModel?.financialYear ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColor().black02,
                      ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.motorCycle ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.passengerCar ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.scooter ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.truck ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.bus ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.lcv ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.tRear ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel?.other ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 20),
              child: CommonTextWidget(
                demoModel?.total ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
