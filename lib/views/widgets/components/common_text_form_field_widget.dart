import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonTextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final bool isMandatory;
  final bool isObscure;
  final String? icon;
  final bool? isPasswordField;
  final VoidCallback? onSuffixTap;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? isReadOnly;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;

  /// [CommonTextFormFieldWidget] will be used as the common text field in this project.
  ///
  /// [hintText] is required field for hintText.
  ///
  /// [isMandatory] is required field for marking TextformField as Mandatory
  ///
  /// [controller] is required field for controller
  ///
  /// [isObscure] is optional field for making text obscure, by default is false
  ///
  /// [icon] is optional field for suffix image icon
  ///
  /// [isPasswordField] is optional field for password icons, by default is false
  ///
  /// [onSuffixTap] is optional field for onTap function of gestureDetector

  const CommonTextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.isMandatory,
      required this.controller,
      this.isObscure = false,
      this.icon,
      this.isPasswordField = false,
      this.textInputType = TextInputType.text,
      this.validator,
      this.isReadOnly,
      this.isPassword = false,
      this.onSuffixTap});

  @override
  State<CommonTextFormFieldWidget> createState() =>
      _CommonTextFormFieldWidgetState();
}

class _CommonTextFormFieldWidgetState extends State<CommonTextFormFieldWidget> {
  bool isClick = true;
  void onClickTextField() {
    setState(() {
      if (widget.controller.text.isEmpty ||
          widget.controller.text.trim() == '') {
        widget.controller.clear();
        isClick = true;
      }
    });
  }

  void removeEmptySpace() {
    setState(() {
      if (widget.controller.text.isNotEmpty) {
        widget.controller.text = widget.controller.text.trim();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        onClickTextField();
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TextFormField(
          controller: widget.controller,
          onTap: () {
            setState(() {
              isClick = false;
            });
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
            removeEmptySpace();
            onClickTextField();
          },
          onFieldSubmitted: (value) {
            onClickTextField();
            removeEmptySpace();
          },
          obscureText: widget.isObscure,
          cursorColor: AppColor().grey919191,
          autovalidateMode: AutovalidateMode.always,
          validator: widget.validator,
          obscuringCharacter: '*',
          readOnly: widget.isReadOnly ?? false,
          keyboardType: widget.textInputType,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: AppColor().black1A1A1A,
              fontWeight: widget.isObscure ? FontWeight.w400 : FontWeight.w400,
              letterSpacing: widget.isObscure ? 5 : null),
          decoration: InputDecoration(
              prefixIcon: isClick == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 14, left: 20),
                      child: CommonTextWidget(
                        widget.hintText,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor().grey919191),
                      ),
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 20),
              hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: AppColor().redFF3333, fontWeight: FontWeight.w400),
              hintText: widget.isMandatory
                  ? isClick
                      ? '  *'
                      : ""
                  : "",
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide:
                      BorderSide(color: AppColor().greyCCCCCC, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide:
                      BorderSide(color: AppColor().greyCCCCCC, width: 1)),
              suffixIcon: widget.icon != null
                  ? suffixWidget()
                  : widget.isPasswordField == true
                      ? GestureDetector(
                          onTap: widget.onSuffixTap,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: CommonImageWidget(
                                width: 30,
                                fit: BoxFit.fitWidth,
                                imageSource: widget.isObscure
                                    ? ImageConstants().eyesClose
                                    : ImageConstants().eyesOpen,
                                isNetworkImage: false),
                          ),
                        )
                      : null),
        ),
      ),
    );
  }

  GestureDetector suffixWidget() {
    return GestureDetector(
      onTap: widget.onSuffixTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: CommonImageWidget(
            width: 30,
            fit: BoxFit.fitWidth,
            imageSource: widget.icon ?? "",
            isNetworkImage: false),
      ),
    );
  }
}
