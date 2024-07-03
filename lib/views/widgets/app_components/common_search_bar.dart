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
  final VoidCallback? onFilterTap;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final Color? textColor;
  final void Function()? onTap;
  final void Function()? onBackButtonTap;
  final void Function(String)? onChanged;
  final ValueChanged<String>? onStartEditing;
  final bool? isSearchExpanded;
  final bool? showFilter;
  final bool? isBackButton;

  /// [CommonSearchBarWidget] will be used as the common search header.

  const CommonSearchBarWidget({
    super.key,
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
    this.showFilter = false,
    this.isBackButton = false,
    this.onBackButtonTap,
    this.onFilterTap,
  });

  @override
  State<CommonSearchBarWidget> createState() =>
      _CommonSearchBarWidgetNewState();
}

class _CommonSearchBarWidgetNewState extends State<CommonSearchBarWidget> {
  String? error;
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();

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
          if (widget.isBackButton == true && widget.isSearchExpanded == false)
            GestureDetector(
              onTap: widget.onBackButtonTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 4),
                child: CommonImageWidget(
                    imageSource: imageConstants.arrowBack,
                    isNetworkImage: false),
              ),
            ),
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
                      cursorColor: appColor.black,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: widget.textColor ?? appColor.black90,
                          decoration: TextDecoration.none,
                          decorationColor: appColor.transparent,
                          letterSpacing: 0),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 20),
                          errorStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: appColor.transparent, fontSize: 1),
                          hintText: widget.hintText.i18n(),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: appColor.grey01),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appColor.grey03)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appColor.grey03)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: appColor.grey03)),
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
                                      ? imageConstants.removeIcon
                                      : imageConstants.searchIcon,
                                  isNetworkImage: false),
                            ),
                          )),
                    )),
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
                        imageSource: imageConstants.removeIcon,
                        isNetworkImage: false,
                        width: 24,
                        height: 24,
                        imageColor: appColor.black,
                      )
                    : CommonImageWidget(
                        imageSource: widget.showFilter == true
                            ? imageConstants.searchIconLarge
                            : imageConstants.searchIcon,
                        isNetworkImage: false,
                        width: widget.showFilter == true ? 17 : 20,
                        height: widget.showFilter == true ? 17 : 20,
                      )),
          ),
          if (widget.showFilter == true && widget.isSearchExpanded == false)
            const SizedBox(
              width: 20,
            ),
          if (widget.showFilter == true && widget.isSearchExpanded == false)
            GestureDetector(
              onTap: widget.onFilterTap,
              child: CommonImageWidget(
                imageSource: imageConstants.filter,
                isNetworkImage: false,
                width: 16,
                height: 16,
              ),
            )
        ],
      ),
    );
  }
}
