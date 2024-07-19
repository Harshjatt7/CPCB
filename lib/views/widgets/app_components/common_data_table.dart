import 'package:cpcb_tyre/models/response/auditor/producer/producer_form_2_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_data_row.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonDataTable extends StatelessWidget {
  CommonDataTable({super.key, required this.headingList,this.list});
  final ScrollController scrollController = ScrollController();
  final List<String> headingList;
  final List<Producers>?  list;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Scrollbar(
        radius: const Radius.circular(5),
        thickness: 5,
        controller: scrollController,
        thumbVisibility: true,
        interactive: true,
        child: ListView.builder(
          controller: scrollController,
          itemCount: 1,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
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
                        headingList.length,
                        (index) => SizedBox(
                              width: 150,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: CommonTextWidget(
                                  headingList[index],
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
                    children: List.generate(1, (index) {
                      return CommonProducerDataRow(
                        demoModel: list?[index],
                        isOdd: index % 2 == 0,
                      );
                    }),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
