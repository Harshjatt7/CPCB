import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_data_row.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/response/auditor/producer/producer_form_2_response_model.dart';

class ProducerDataTable extends StatelessWidget {
  ProducerDataTable({super.key, required this.headingList,this.list});
  final ScrollController scrollController = ScrollController();
  final List<String> headingList;
  final List<P1>? list;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: const Radius.circular(5),
      thickness: 5,
      controller: scrollController,
      thumbVisibility: true,
      interactive: true,
      child: CommonSingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor().grey20,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    border: Border(
                        top: BorderSide(color: AppColor().grey40),
                        left: BorderSide(color: AppColor().grey40),
                        right: BorderSide(color: AppColor().grey40))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      producerHeadingList.length,
                      (index) => SizedBox(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: CommonTextWidget(
                                producerHeadingList[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColor().black01),
                              ),
                            ),
                          )),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    border: Border.all(color: AppColor().grey40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(list?.length??0, (index) {
                    return CommonProducerDataRow(
                      demoModel: list?[index],
                      isOdd: index % 2 == 0,
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<String> producerHeadingList = [
  "Type of Tyre",
  "Financial Year",
  "Motorcycle",
  "Passenger Car",
  "Scooter",
  "Truck",
  "Bus",
  "LCV",
  "T Rear",
  "Other",
  "Total"
];
