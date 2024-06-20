import 'package:cpcb_tyre/constants/enums/filter_enums.dart';
import 'package:cpcb_tyre/models/response/filter/checkbox_filter_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_row_heading_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonExpansionTile extends StatefulWidget {
  final String title;
  bool? isChecked;
  bool? isShowHide;
  final List<CheckboxFilterModel> checkBoxList;
  final List<String> selectedList;
  final FilterTypes type;
  CommonExpansionTile(
      {super.key,
      required this.title,
      this.isChecked,
      this.isShowHide,
      required this.checkBoxList,
      required this.selectedList,
      required this.type});

  @override
  State<CommonExpansionTile> createState() => _CommonExpansionTileState();
}

class _CommonExpansionTileState extends State<CommonExpansionTile> {
  final _appColor = AppColor();

  void updateState(FilterTypes types, {bool? value, bool? isShowHide}) {
    switch (types) {
      case FilterTypes.state:
        widget.isChecked = value;
        widget.isShowHide = isShowHide;
        // isUnitShowHide = false;
        // isCurrentShowHide = false;
        //  stateExpansionTileController.expand();

        // if (currentExpansionTileController.isExpanded == true) {
        //   currentExpansionTileController.collapse();
        // }

        // if (unitExpansionTileController.isExpanded == true) {
        //   unitExpansionTileController.collapse();
        // }
        //stateExpansionTileController.expand();
        break;
      case FilterTypes.unitType:
        widget.isChecked = value;
        widget.isShowHide = isShowHide;
        // isStateShowHide = false;
        // isCurrentShowHide = false;

        // if(unitExpansionTileController.isExpanded == false)
        // unitExpansionTileController.expand();

        // if (currentExpansionTileController.isExpanded == true) {
        //   currentExpansionTileController.collapse();
        // }

        // if (stateExpansionTileController.isExpanded == true) {
        //   stateExpansionTileController.collapse();
        // }
        //unitExpansionTileController.expand();
        break;
      case FilterTypes.currentStatus:
        widget.isChecked = value;
        widget.isShowHide = isShowHide;
        // isUnitShowHide = false;
        // isCurrentShowHide = false;
        // currentExpansionTileController.expand();
        // if (stateExpansionTileController.isExpanded == true) {
        //   stateExpansionTileController.collapse();
        // }

        // if (unitExpansionTileController.isExpanded == true) {
        //   unitExpansionTileController.collapse();
        // }
        // currentExpansionTileController.expand();

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: _appColor.black,
      trailing: Icon(
        widget.isShowHide != null && widget.isShowHide == true
            ? Icons.keyboard_arrow_down
            : Icons.keyboard_arrow_right,
      ),
      onExpansionChanged: (val) {
        updateState(widget.type, isShowHide: val, value: widget.isChecked);
        setState(() {});
      },
      title: CommonFilterViewHeading(
        checkboxFilterModel: CheckboxFilterModel(
            title: widget.title, isChecked: widget.isChecked),
        updateState: (value) {
          updateState(widget.type, value: value, isShowHide: widget.isShowHide);

          setState(() {});
          if (value == true) {
            for (var element in widget.checkBoxList) {
              element.isChecked = true;
              widget.selectedList.add(element.title);
              setState(() {});
            }
          } else if (value == false) {
            for (var element in widget.checkBoxList) {
              element.isChecked = false;
              setState(() {});
            }
            widget.selectedList.clear();
          } else {}
        },
      ),
      children: List<Widget>.generate(
          widget.checkBoxList.length,
          (index) => CommonFilterViewHeading(
                checkboxFilterModel: CheckboxFilterModel(
                    title: widget.checkBoxList[index].title,
                    isChecked: widget.checkBoxList[index].isChecked ??
                        widget.isChecked),
                isBorder: true,
                updateState: (value) {
                  widget.checkBoxList[index].isChecked = value;
                  if (value == true) {
                    widget.selectedList.add(widget.checkBoxList[index].title);
                  } else {
                    if (widget.selectedList
                        .contains(widget.checkBoxList[index].title)) {
                      widget.selectedList
                          .remove(widget.checkBoxList[index].title);
                    }
                  }
                  if (widget.selectedList.isNotEmpty &&
                      widget.selectedList.length < widget.checkBoxList.length) {
                    updateState(widget.type, value: null, isShowHide: true);
                  } else if (widget.selectedList.length ==
                      widget.checkBoxList.length) {
                    updateState(widget.type, value: true, isShowHide: true);
                  } else if (widget.selectedList.isEmpty) {
                    updateState(widget.type, value: false, isShowHide: true);
                  }
                  setState(() {});
                },
              )),
    );
  }
}
