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
  final bool? isLastField;
  final Color? iconColor;
  final Color? bgColor;
  final bool? useLocalization;

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
  ///
  /// [isLastField] will be true if the textfield is last in any given form to show he "done" or check button in keyboard.
  /// By default it's value will be false.

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
      this.bgColor,
      this.isDocument,
      this.isLastField = false,
      this.iconColor,
      this.useLocalization = true});

  @override
  State<CommonTextFormFieldWidget> createState() =>
      _CommonTextFormFieldWidgetNewState();
}

class _CommonTextFormFieldWidgetNewState
    extends State<CommonTextFormFieldWidget> {
  late FocusNode _focusNode;
  bool isClick = true;
  String? error;
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();

  void removeEmptySpace() {
    setState(() {
      if (widget.controller.text.isNotEmpty) {
        widget.controller.text = widget.controller.text.trim();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(() {
      if (widget.validator != null) {
        error = widget.validator!(widget.controller.text);
      }
      if (context.mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      removeEmptySpace();
    }
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
                  ? widget.disabledBgColor ?? appColor.grey03
                  : widget.bgColor ?? appColor.transparent,
              border: Border.all(
                  color: error != null ? appColor.red : appColor.black20),
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            inputFormatters: widget.inputFormatters ??
                [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@. ]')),
                ],
            enableInteractiveSelection: true,
            controller: widget.controller,
            focusNode: widget.isReadOnly == true
                ? AlwaysDisabledFocusNode()
                : _focusNode,
            obscureText: widget.isObscure,
            cursorColor: appColor.grey01,
            showCursor: true,
            cursorErrorColor: appColor.grey01,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (widget.validator != null) {
                error = widget.validator!(widget.controller.text);

                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  if (context.mounted) {
                    setState(() {});
                  }
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
            style: widget.isDocument == true
                ? Theme.of(context).textTheme.displaySmall!.copyWith(
                    height: 1.5,
                    color: widget.textColor ?? appColor.black90,
                    decoration: widget.isDocument == true
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    letterSpacing: widget.isObscure ? 5 : null)
                : Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: widget.textColor ?? appColor.black90,
                    decoration: widget.isDocument == true
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    letterSpacing: widget.isObscure ? 5 : null),
            textInputAction: widget.isLastField == true ||
                    widget.textInputType == TextInputType.number
                ? TextInputAction.done
                : TextInputAction.next,
            decoration: InputDecoration(
                fillColor: widget.isReadOnly == true
                    ? widget.disabledBgColor ?? appColor.grey03
                    : appColor.transparent,
                filled: widget.isReadOnly ?? false,
                label: RichText(
                  maxLines: 1,
                  text: TextSpan(
                    text: widget.useLocalization == true
                        ? widget.hintText.i18n()
                        : widget.hintText,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: appColor.grey01,
                        ),
                    children: [
                      TextSpan(
                        text: widget.isMandatory == true ? " *" : "",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: appColor.red),
                      ),
                    ],
                  ),
                ),
                contentPadding:
                    const EdgeInsets.only(top: 8, bottom: 6, left: 20),
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: appColor.transparent, fontSize: 1),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                suffixIconColor: widget.iconColor ?? appColor.black70,
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
                                      ? imageConstants.eyesClose
                                      : imageConstants.eyesOpen,
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
                  ?.copyWith(color: appColor.red),
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
          isNetworkImage: false,
          imageColor: widget.iconColor ?? appColor.black,
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
