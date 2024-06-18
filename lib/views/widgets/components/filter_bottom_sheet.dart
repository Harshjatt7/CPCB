import 'package:cpcb_tyre/constants/enums/filter_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/filter/checkbox_filter_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_row_heading_list.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<CheckboxFilterModel> stateList;
  final List<CheckboxFilterModel> unitList;
  final List<CheckboxFilterModel> currentList;
  final void Function()? onTitleUpdated;
  final void Function()? onClose;
  final void Function()? onApply;

  const FilterBottomSheet(
      {super.key,
      required this.stateList,
      this.onTitleUpdated,
      required this.currentList,
      required this.unitList,
      this.onApply,
      this.onClose});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final _appColor = AppColor();
  final _stringConstants = StringConstants();
  bool? isStateChecked = false;
  bool? isUnitChecked = false;
  bool? isCurrentStatus = false;
  bool? isStateShowHide = false;
  bool? isUnitShowHide = false;
  bool? isCurrentShowHide = false;
  List<String> selectedStateList = [];
  List<String> selectedUnitList = [];
  List<String> selectedCurrentList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _appColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: CommonSingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 6,
              width: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: _appColor.black20),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CommonTextWidget(
                  _stringConstants.filter,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: _appColor.black90),
                ),
              ),
            ),
            expandedDropDown(
                _stringConstants.state,
                isStateChecked,
                isStateShowHide,
                widget.stateList,
                selectedStateList,
                FilterTypes.state),
            if (isStateShowHide == false)
              Divider(
                color: _appColor.black20,
              ),
            expandedDropDown(
                _stringConstants.unitType,
                isUnitChecked,
                isUnitShowHide,
                widget.unitList,
                selectedUnitList,
                FilterTypes.unitType),
            if (isUnitShowHide == false)
              Divider(
                color: _appColor.black20,
              ),
            expandedDropDown(
                _stringConstants.currentStatus,
                isCurrentStatus,
                isCurrentShowHide,
                widget.currentList,
                selectedCurrentList,
                FilterTypes.currentStatus),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Flexible(
                    child: CommonButtonWidget(
                      label: _stringConstants.close,
                      color: _appColor.white,
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      onPressed: widget.onClose,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: CommonButtonWidget(
                        label: _stringConstants.apply,
                        color: _appColor.darkGreen,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: _appColor.white),
                        onPressed: widget.onApply,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateSelectAll(FilterTypes types, {bool? value, bool? isShowHide}) {
    switch (types) {
      case FilterTypes.state:
        isStateChecked = value;
        isStateShowHide = isShowHide;
        break;
      case FilterTypes.unitType:
        isUnitChecked = value;
        isUnitShowHide = isShowHide;
        break;
      case FilterTypes.currentStatus:
        isCurrentStatus = value;
        isCurrentShowHide = isShowHide;
        break;
    }
  }

  Widget expandedDropDown(
      String title,
      bool? isChecked,
      bool? isShowHide,
      List<CheckboxFilterModel> checkBoxList,
      List<String> selectedList,
      FilterTypes type) {
    return ExpansionTile(
      trailing: Icon(
        isShowHide != null && isShowHide == true
            ? Icons.keyboard_arrow_down
            : Icons.keyboard_arrow_right,
      ),
      onExpansionChanged: (val) {
        updateSelectAll(type, isShowHide: val, value: isChecked);
        setState(() {});
      },
      title: CommonFilterViewHeading(
        checkboxFilterModel:
            CheckboxFilterModel(title: title, isChecked: isChecked),
        updateState: (value) {
          updateSelectAll(type, value: value, isShowHide: isShowHide);

          setState(() {});
          if (value == true) {
            for (var element in checkBoxList) {
              element.isChecked = true;
              selectedList.add(element.title);
              setState(() {});
            }
          } else if (value == false) {
            for (var element in checkBoxList) {
              element.isChecked = false;
              setState(() {});
            }
            selectedList.clear();
          } else {}
        },
      ),
      children: List<Widget>.generate(
          checkBoxList.length,
          (index) => CommonFilterViewHeading(
                checkboxFilterModel: CheckboxFilterModel(
                    title: checkBoxList[index].title,
                    isChecked: checkBoxList[index].isChecked ?? isChecked),
                isBorder: true,
                updateState: (value) {
                  checkBoxList[index].isChecked = value;
                  if (value == true) {
                    selectedList.add(checkBoxList[index].title);
                  } else {
                    if (selectedList.contains(checkBoxList[index].title)) {
                      selectedList.remove(checkBoxList[index].title);
                    }
                  }
                  if (selectedList.isNotEmpty &&
                      selectedList.length < checkBoxList.length) {
                    updateSelectAll(type, value: null, isShowHide: true);
                  } else if (selectedList.length == checkBoxList.length) {
                    updateSelectAll(type, value: true, isShowHide: true);
                  } else if (selectedList.isEmpty) {
                    updateSelectAll(type, value: false, isShowHide: true);
                  }
                  setState(() {});
                },
              )),
    );
  }
}
