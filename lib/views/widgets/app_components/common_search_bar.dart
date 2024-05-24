import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonSearchBarWidget extends StatefulWidget {
  final String hintText;
  final String? title;
  final String? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final Color? textColor;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final ValueChanged<String>? onStartEditing;
  final bool? isSearchExpanded;
  final bool? showFilter;

  /// [CommonSearchBarWidget] will be used as the common search header.

  const CommonSearchBarWidget(
      {super.key,
      this.title,
      required this.hintText,
      required this.controller,
      this.textColor,
      this.textInputType = TextInputType.text,
      this.onSuffixTap,
      this.onChanged,
      this.onTap,
      this.onStartEditing,
      this.suffixIcon,
      this.isSearchExpanded = false,
      this.showFilter = false});

  @override
  State<CommonSearchBarWidget> createState() =>
      _CommonSearchBarWidgetNewState();
}

class _CommonSearchBarWidgetNewState extends State<CommonSearchBarWidget> {
  String? error;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      widget.onChanged;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Visibility(
            visible: !(widget.isSearchExpanded ?? false),
            child: Expanded(
              child: SizedBox(
                child: CommonTextWidget(
                  widget.title ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
          Visibility(
              visible: widget.isSearchExpanded ?? false,
              child: Flexible(
                child: SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      onChanged: widget.onChanged,
                      controller: widget.controller,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 20),
                          errorStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColor().transparent, fontSize: 1),
                          hintText: widget.hintText.i18n(),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppColor().grey01),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor().grey03)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor().grey03)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor().grey03)),
                          suffixIcon: GestureDetector(
                            onTap: widget.onSuffixTap,
                            child: Container(
                              width: 22,
                              height: 22,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CommonImageWidget(
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  imageSource: widget.isSearchExpanded ?? false
                                      ? ImageConstants().removeIcon
                                      : ImageConstants().searchIcon,
                                  isNetworkImage: false),
                            ),
                          )),
                    )
// TODO: old textfield for reference, to be remoed
                    //     CommonTextFormFieldWidget(
                    //   controller: widget.controller,
                    //   hintText: StringConstants().search,
                    //   isMandatory: false,
                    //   isPasswordField: true,
                    //   onChanged: widget.onChanged,
                    //   icon: widget.isSearchExpanded ?? false
                    //       ? ImageConstants().removeIcon
                    //       : ImageConstants().searchIcon,
                    //   onSuffixTap: () {
                    //     widget.onSuffixTap!();
                    //   },
                    // ),
                    ),
              )),
          Visibility(
            visible: !(widget.isSearchExpanded ?? false),
            child: GestureDetector(
                onTap: () {
                  if (widget.onSuffixTap != null) {
                    widget.onSuffixTap!();
                  }
                },
                child: widget.isSearchExpanded ?? false
                    ? CommonImageWidget(
                        imageSource: ImageConstants().removeIcon,
                        isNetworkImage: false,
                        width: 24,
                        height: 24,
                        imageColor: AppColor().black,
                      )
                    : CommonImageWidget(
                        imageSource: ImageConstants().searchIcon,
                        isNetworkImage: false,
                        width: 24,
                        height: 24,
                      )),
          ),
          if (widget.showFilter == true)
            const SizedBox(
              width: 15,
            ),
          if (widget.showFilter == true)
            GestureDetector(
              onTap: () {},
              child: CommonImageWidget(
                imageSource: ImageConstants().filter,
                isNetworkImage: false,
                width: 24,
                height: 24,
              ),
            )
        ],
      ),
    );
  }
}

// class AlwaysDisabledFocusNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }
