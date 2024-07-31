import 'package:cpcb_tyre/views/widgets/app_components/common_row_heading_list.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import '../../../constants/enums/filter_enums.dart';
import '../../../models/response/filter/checkbox_filter_model.dart';

// ignore: must_be_immutable
class CommonExpansionTile extends StatefulWidget {
  final String title;
  bool? isChecked;
  bool? isShowHide;
  final List<CheckboxFilterModel> checkBoxList;
  final List<String> selectedList;
  final List<String> tempSelectedList;
  final FilterTypes type;
  final Function(List<String>)? listCallBack;
  CommonExpansionTile(
      {super.key,
      required this.title,
      this.isChecked = false,
      this.isShowHide,
      required this.checkBoxList,
      required this.selectedList,
      required this.tempSelectedList,
      required this.type,
      this.listCallBack});
  @override
  State<CommonExpansionTile> createState() => _CommonExpansionTileState();
}
class _CommonExpansionTileState extends State<CommonExpansionTile> {
  final _appColor = AppColor();
  List<String> tempSelectedList = [];
  int countOfFalse = 0;
  bool? mainIsChecked = false;

  @override
  void initState() {
    for (var element in widget.checkBoxList) {
      if (widget.selectedList.contains(element.title)) {
        element.isChecked = true;
        tempSelectedList.add(element.title);
        widget.tempSelectedList.add(element.title);
      } else {
        element.isChecked = false;
        countOfFalse++;
      }
    }

    if (countOfFalse > 0 && (countOfFalse < widget.checkBoxList.length)) {
      widget.isChecked = null;
    } else if (widget.selectedList.isEmpty) {
      widget.isChecked = false;
    } else {
      widget.isChecked = true;
    }

    mainIsChecked = widget.isChecked;

    super.initState();
  }

  void updateState(FilterTypes types, {bool? value, bool? isShowHide}) {
    switch (types) {
      case FilterTypes.state:
        mainIsChecked = value;
        widget.isShowHide = isShowHide;

        break;
      case FilterTypes.unitType:
        mainIsChecked = value;
        widget.isShowHide = isShowHide;

        break;
      case FilterTypes.currentStatus:
        mainIsChecked = value;
        widget.isShowHide = isShowHide;

        break;
      case FilterTypes.district:
        mainIsChecked = value;
        widget.isShowHide = isShowHide;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (countOfFalse > 0 && (countOfFalse < widget.checkBoxList.length)) {
    //   widget.isChecked = null;
    // } else if (widget.selectedList.isEmpty) {
    //   widget.isChecked = false;
    // } else if (tempSelectedList.length == widget.checkBoxList.length) {
    //   widget.isChecked = true;
    // }
    return ExpansionTile(
        iconColor: _appColor.black,
        trailing: Icon(
          widget.isShowHide != null && widget.isShowHide == true
              ? Icons.keyboard_arrow_down
              : Icons.keyboard_arrow_right,
        ),
        onExpansionChanged: (val) {
          updateState(widget.type, isShowHide: val, value: mainIsChecked);
          setState(() {});
        },
        title: CommonFilterViewHeading(
          checkboxFilterModel: CheckboxFilterModel(
              title: widget.title, isChecked: mainIsChecked),
          updateState: (value) {
            updateState(widget.type,
                value: value, isShowHide: widget.isShowHide);

            setState(() {});
            if (value == true) {
              for (var element in widget.checkBoxList) {
                element.isChecked = true;

                tempSelectedList.add(element.title);

                setState(() {});
              }
            } else if (value == false) {
              for (var element in widget.checkBoxList) {
                element.isChecked = false;
                tempSelectedList.remove(element.title);
                setState(() {});
              }
            } else {}

            if (widget.listCallBack != null) {
              widget.listCallBack!(tempSelectedList);
            }
          },
        ),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                    itemCount: widget.checkBoxList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                          bottom: BorderSide(
                            color: _appColor.black10,
                          ),
                          end: BorderSide(
                            color: _appColor.black10,
                          ),
                          start: BorderSide(
                            color: _appColor.black10,
                          ),
                        )),
                        child: CommonFilterViewHeading(
                          checkboxFilterModel: CheckboxFilterModel(
                              title: widget.checkBoxList[index].title,
                              isChecked: widget.checkBoxList[index].isChecked ??
                                  false),
                          //isBorder: true,
                          updateState: (value) {
                            widget.checkBoxList[index].isChecked = value;
                            if (value == true) {
                              tempSelectedList
                                  .add(widget.checkBoxList[index].title);
                            } else {
                              if (tempSelectedList
                                  .contains(widget.checkBoxList[index].title)) {
                                tempSelectedList
                                    .remove(widget.checkBoxList[index].title);
                              }
                            }
                            if (tempSelectedList.isNotEmpty &&
                                tempSelectedList.length <
                                    widget.checkBoxList.length) {
                              updateState(widget.type,
                                  value: null, isShowHide: true);
                            } else if (tempSelectedList.length ==
                                widget.checkBoxList.length) {
                              updateState(widget.type,
                                  value: true, isShowHide: true);
                            } else if (tempSelectedList.isEmpty) {
                              updateState(widget.type,
                                  value: false, isShowHide: true);
                            }
                            setState(() {});
                            if (widget.listCallBack != null) {
                              widget.listCallBack!(tempSelectedList);
                            }

                            //widget.selectedList.clear();
                          },
                        ),
                      );
                    }),
              ),
              Divider(
                color: _appColor.black10,
              )
            ],
          )
        ]

        // List<Widget>.generate(
        //     widget.checkBoxList.length,
        //     (index) => CommonFilterViewHeading(
        //           checkboxFilterModel: CheckboxFilterModel(
        //               title: widget.checkBoxList[index].title,
        //               isChecked: widget.checkBoxList[index].isChecked ??
        //                   widget.isChecked),
        //           //isBorder: true,
        //           updateState: (value) {
        //             widget.checkBoxList[index].isChecked = value;
        //             if (value == true) {
        //               tempSelectedList.add(widget.checkBoxList[index].title);
        //             } else {
        //               if (tempSelectedList.contains(widget.checkBoxList[index].title)) {
        //                 tempSelectedList.remove(widget.checkBoxList[index].title);
        //               }
        //             }
        //             if (tempSelectedList.isNotEmpty &&
        //                 tempSelectedList.length < widget.checkBoxList.length) {
        //               updateState(widget.type, value: null, isShowHide: true);
        //             } else if (tempSelectedList.length == widget.checkBoxList.length) {
        //               updateState(widget.type, value: true, isShowHide: true);
        //             } else if (tempSelectedList.isEmpty) {
        //               updateState(widget.type, value: false, isShowHide: true);
        //             }
        //             setState(() {});
        //             if (widget.listCallBack != null) {
        //               widget.listCallBack!(tempSelectedList);
        //             }
        //           },
        //         )),

        );
  }
}
