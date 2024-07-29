import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form1_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_recycler_data_row.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecyclerDataTable extends StatelessWidget {
  RecyclerDataTable(
      {super.key,
      required this.headingList,
      required this.nwList,
      required this.machineControllerList,
      required this.radioList});
  final List<String> headingList;
  final List<Nw> nwList;
  final List<TextEditingController> machineControllerList;
  final List<String> radioList;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeBottom: true),
      child: Scrollbar(
        radius: const Radius.circular(5),
        thickness: 5,
        // controller: scrollController,
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
                      headingList.length,
                      (index) => SizedBox(
                            width: 286,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(nwList.length, (index) {
                    return CommonRecyclerDataRow(
                      index: index,
                      machineController: machineControllerList[index],
                      nwModel: nwList[index],
                      groupValue: radioList[index],
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
