import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterBottomSheet extends StatefulWidget {
  final List<Widget> filterTiles;
  final void Function()? onTitleUpdated;
  final void Function()? onClose;
  final void Function()? onApply;

  const FilterBottomSheet(
      {super.key,
      this.onTitleUpdated,
      required this.filterTiles,
      this.onApply,
      this.onClose});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final _appColor = AppColor();
  final _stringConstants = StringConstants();

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
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextWidget(
                  _stringConstants.filter,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: _appColor.black90),
                ),
              ),
            ),
            Column(
              children:
                  List<Widget>.generate(widget.filterTiles.length, (index) {
                return widget.filterTiles[index];
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
}
