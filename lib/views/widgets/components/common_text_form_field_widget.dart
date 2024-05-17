import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';

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
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;
  final Color? disabledBgColor;
  final void Function()? onTap;
  final bool? isDocument;
  final void Function(String)? onChanged;

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
  ///
  /// [inputFormatters] will be used to send any input formatters if required.
  ///
  /// [disabledBgColor] will be used to set the background color of textfield where [isReadOnly] is true,
  /// if no color is given it will use the default disabled background color.

  const CommonTextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.isMandatory,
      required this.controller,
      this.isObscure = false,
      this.icon,
      this.textColor,
      this.isPasswordField = false,
      this.textInputType = TextInputType.text,
      this.validator,
      this.isReadOnly = false,
      this.isPassword = false,
      this.onSuffixTap,
      this.onChanged,
      this.disabledBgColor,
      this.onTap,
      this.inputFormatters,
      this.isDocument});

  @override
  State<CommonTextFormFieldWidget> createState() =>
      _CommonTextFormFieldWidgetNewState();
}

class _CommonTextFormFieldWidgetNewState
    extends State<CommonTextFormFieldWidget> {
  late FocusNode _focusNode;
  bool isClick = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(() {
      if (widget.validator != null) {
        error = widget.validator!(widget.controller.text);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
          
              color: widget.isReadOnly == true
                  ? widget.disabledBgColor ?? AppColor().grey03
                  : AppColor().transparent,
              border: Border.all(
                  color: error != null ? AppColor().red : AppColor().black20),
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            onChanged:widget.onChanged ,
            onTap: widget.onTap,
            inputFormatters: widget.inputFormatters ??
                [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@. ]')),
                ],
            enableInteractiveSelection: false,
            controller: widget.controller,
            focusNode: widget.isReadOnly == true
                ? AlwaysDisabledFocusNode()
                : _focusNode,
            obscureText: widget.isObscure,
            cursorColor: AppColor().grey01,
            showCursor: true,
            cursorErrorColor: AppColor().grey01,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (widget.validator != null) {
                error = widget.validator!(widget.controller.text);

                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {});
                });
              }

              return widget.validator == null
                  ? null
                  : widget.validator!(widget.controller.text);
            },
            obscuringCharacter: '*',
            readOnly: widget.isReadOnly ?? false,
            cursorHeight: 20,
            keyboardType: widget.textInputType ?? TextInputType.text,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: widget.textColor ?? AppColor().black90,
                decoration: widget.isDocument==true ? TextDecoration.underline:TextDecoration.none,
                letterSpacing: widget.isObscure ? 5 : null),
            decoration: InputDecoration(
                fillColor: widget.isReadOnly == true
                  ? widget.disabledBgColor ?? AppColor().grey03
                  : AppColor().transparent,
                filled: widget.isReadOnly ?? false,
                label: RichText(
                  text: TextSpan(
                    text: widget.hintText.i18n(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColor().grey01),
                    children: [
                      TextSpan(
                        text: widget.isMandatory ? " *" : "",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppColor().red),
                      ),
                    ],
                  ),
                ),
                contentPadding:
                    const EdgeInsets.only(top: 8, bottom: 8, left: 20),
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColor().transparent, fontSize: 1),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                suffixIcon: widget.icon != null
                    ? suffixWidget()
                    : widget.isPasswordField == true
                        ? GestureDetector(
                            onTap: widget.onSuffixTap,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: CommonImageWidget(
                                  width: 20,
                                  fit: BoxFit.contain,
                                  imageSource: widget.isObscure
                                      ? ImageConstants().eyesClose
                                      : ImageConstants().eyesOpen,
                                  isNetworkImage: false),
                            ),
                          )
                        : null),
          ),
        ),
        if (error != null)
          Align(
            alignment: Alignment.topLeft,
            child: CommonTextWidget(
              error.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColor().red),
            ),
          ),
      ],
    );
  }

  GestureDetector suffixWidget() {
    return GestureDetector(
      onTap: widget.onSuffixTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: CommonImageWidget(
            width: 20,
            fit: BoxFit.fitWidth,
            imageSource: widget.icon ?? "",
            isNetworkImage: false),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
