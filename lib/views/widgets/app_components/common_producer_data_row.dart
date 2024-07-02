import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonProducerDataRow extends StatelessWidget {
  const CommonProducerDataRow(
      {super.key, required this.demoModel, this.onTap, required this.isOdd});
  final DemoModel demoModel;
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
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 30),
              child: CommonTextWidget(
                demoModel.typeOfTyre ?? '',
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
                  demoModel.financialYear ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AppColor().black02,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel.motorcycle ?? '',
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
                demoModel.passengerCar ?? '',
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
                demoModel.scooter ?? '',
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
                demoModel.truck ?? '',
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
                demoModel.bus ?? '',
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
                demoModel.lcv ?? '',
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
                demoModel.tRear ?? '',
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
                demoModel.other ?? '',
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
                demoModel.total ?? '',
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

List<String> producerDemoList = [
  "Radial",
  "Aadhaar Card",
  "1100",
  "1100",
  "100",
  "1100",
  "110",
  "1121",
  "1321",
  "3313",
  "1313"
];

class DemoModel {
  String? typeOfTyre;
  String? financialYear;
  String? passengerCar;
  String? scooter;
  String? bus;
  String? lcv;
  String? truck;
  String? motorcycle;
  String? total;
  String? tRear;
  String? other;

  DemoModel(
      {this.typeOfTyre,
      this.financialYear,
      this.passengerCar,
      this.scooter,
      this.bus,
      this.lcv,
      this.truck,
      this.motorcycle,
      this.total,
      this.tRear,
      this.other});
}

List<DemoModel> list = [
  DemoModel(
      bus: "12",
      lcv: "132",
      total: "876",
      truck: "123",
      financialYear: "Aadhaar Card",
      motorcycle: "78",
      other: "44",
      passengerCar: "23",
      scooter: "212",
      tRear: "22",
      typeOfTyre: "Radial"),
  DemoModel(
      bus: "12",
      lcv: "132",
      total: "876",
      truck: "123",
      financialYear: "Driving License",
      motorcycle: "78",
      other: "44",
      passengerCar: "23",
      scooter: "212",
      tRear: "22",
      typeOfTyre: "Biasply"),
  DemoModel(
      bus: "12",
      lcv: "132",
      total: "876",
      truck: "123",
      financialYear: "PAN No",
      motorcycle: "78",
      other: "44",
      passengerCar: "23",
      scooter: "212",
      tRear: "22",
      typeOfTyre: "Solid"),
];
