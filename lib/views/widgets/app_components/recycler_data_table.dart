import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_recycler_data_row.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class RecyclerDataTable extends StatelessWidget {
  RecyclerDataTable({
    super.key,
  });
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: const Radius.circular(5),
      thickness: 5,
      controller: scrollController,
      thumbVisibility: true,
      interactive: true,
      child: CommonSingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                    recyclerHeadingList.length,
                    (index) => SizedBox(
                          width: 286,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            child: CommonTextWidget(
                              recyclerHeadingList[index],
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(list2.length, (index) {
                  return CommonRecyclerDataRow(
                    demoModel: list2[index],
                    isOdd: index % 2 == 0,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<String> recyclerHeadingList = [
  "Name of Plant Machinery",
  "Capacity of Plant Machinery",
  "Power of Plant Machinery",
  "Action",
  "Remarks",
];
