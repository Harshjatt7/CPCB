import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
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
  final bool isClear;
  final List<TextInputFormatter>? inputFormatters;

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
      this.isClear = false,
      this.isReadOnly = false,
      this.isPassword = false,
      this.onSuffixTap,
      this.inputFormatters});

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
          decoration: error != null
              ? BoxDecoration(
                  border: Border.all(color: AppColor().red),
                  borderRadius: BorderRadius.circular(5))
              : BoxDecoration(
                  border: Border.all(color: AppColor().black20),
                  borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            inputFormatters: widget.inputFormatters ??
                [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@ ]')),
                ],
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isObscure,
            cursorColor: AppColor().grey01,
            showCursor: true,
            cursorErrorColor: AppColor().grey01,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (widget.validator != null) {
                error = widget.validator!(widget.controller.text);
              }

              return widget.validator == null
                  ? null
                  : widget.validator!(widget.controller.text);
            },
            obscuringCharacter: '*',
            readOnly: widget.isReadOnly ?? false,
            cursorHeight: 16,
            keyboardType: widget.textInputType ?? TextInputType.text,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: widget.textColor ?? AppColor().black90,
                decoration: TextDecoration.none,
                letterSpacing: widget.isObscure ? 5 : null),
            decoration: InputDecoration(
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


// TODO: To be removed

// import 'package:cpcb_tyre/constants/image_constants.dart';
// import 'package:cpcb_tyre/theme/app_color.dart';
// import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
// import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
// import 'package:flutter/material.dart';

// class CommonTextFormFieldWidget extends StatefulWidget {
//   final String hintText;
//   final bool isMandatory;
//   final bool isObscure;
//   final String? icon;
//   final bool? isPasswordField;
//   final VoidCallback? onSuffixTap;
//   final TextEditingController controller;
//   final bool? isPassword;
//   final bool? isReadOnly;
//   final TextInputType? textInputType;
//   final String? Function(String?)? validator;
//   final Color? textColor;

//   /// [CommonTextFormFieldWidget] will be used as the common text field in this project.
//   ///
//   /// [hintText] is required field for hintText.
//   ///
//   /// [isMandatory] is required field for marking TextformField as Mandatory
//   ///
//   /// [controller] is required field for controller
//   ///
//   /// [isObscure] is optional field for making text obscure, by default is false
//   ///
//   /// [icon] is optional field for suffix image icon
//   ///
//   /// [isPasswordField] is optional field for password icons, by default is false
//   ///
//   /// [onSuffixTap] is optional field for onTap function of gestureDetector

//   const CommonTextFormFieldWidget(
//       {super.key,
//       required this.hintText,
//       required this.isMandatory,
//       required this.controller,
//       this.isObscure = false,
//       this.icon,
//       this.textColor,
//       this.isPasswordField = false,
//       this.textInputType = TextInputType.text,
//       this.validator,
//       this.isReadOnly,
//       this.isPassword = false,
//       this.onSuffixTap});

//   @override
//   State<CommonTextFormFieldWidget> createState() =>
//       _CommonTextFormFieldWidgetState();
// }

// class _CommonTextFormFieldWidgetState extends State<CommonTextFormFieldWidget> {
//   late FocusNode _focusNode;
//   bool isClick = true;
//   void onClickTextField() {
//     setState(() {
//       if ((widget.controller.text.isEmpty ||
//           widget.controller.text.trim() == '')) {
//         widget.controller.clear();
//         isClick = true;
//       }
//     });
//   }

//   void removeEmptySpace() {
//     setState(() {
//       if (widget.controller.text.isNotEmpty) {
//         widget.controller.text = widget.controller.text.trim();
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//     _focusNode.addListener(_handleFocusChange);
//   }

//   @override
//   void dispose() {
//     _focusNode.removeListener(_handleFocusChange);
//     _focusNode.dispose();
//     super.dispose();
//   }

//   void _handleFocusChange() {
//     if (!_focusNode.hasFocus) {
//       onClickTextField();
//       removeEmptySpace();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) {
//         if (didPop) {
//           return;
//         }
//         onClickTextField();
//       },
//       child: TextFormField(
//         controller: widget.controller,
//         onTap: () {
//           setState(() {
//             isClick = false;
//           });
//         },
//         onTapOutside: (event) {
//           FocusManager.instance.primaryFocus?.unfocus();
//           removeEmptySpace();
//           onClickTextField();
//         },
//         onFieldSubmitted: (value) {
//           onClickTextField();
//           removeEmptySpace();
//         },
//         onSaved: (newValue) {
//           onClickTextField();
//           removeEmptySpace();
//         },
//         focusNode: _focusNode,
//         obscureText: widget.isObscure,
//         cursorColor: AppColor().grey01,
//         onTapAlwaysCalled: true,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         validator: widget.validator,
//         obscuringCharacter: '*',
//         readOnly: widget.isReadOnly ?? false,
//         keyboardType: widget.textInputType ?? TextInputType.text,
//         style: Theme.of(context).textTheme.labelSmall!.copyWith(
//             color: widget.textColor ?? AppColor().black90,
//             decoration: TextDecoration.none,
//             // decorationColor: AppColor().transparent,
//             letterSpacing: widget.isObscure ? 5 : null),
//         decoration: InputDecoration(
//             prefixIcon: isClick == true
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 14, left: 20),
//                     child: CommonTextWidget(
//                       widget.hintText,
//                       style: Theme.of(context)
//                           .textTheme
//                           .displaySmall!
//                           .copyWith(color: AppColor().grey01),
//                     ),
//                   )
//                 : null,
//             contentPadding:
//                 const EdgeInsets.only(top: 16, bottom: 16, left: 20),
//             hintStyle: Theme.of(context)
//                 .textTheme
//                 .labelSmall!
//                 .copyWith(color: AppColor().red),
//             hintText: widget.isMandatory
//                 ? isClick
//                     ? '  *'
//                     : ""
//                 : "",
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(5)),
//                 borderSide: BorderSide(color: AppColor().red, width: 1)),
//             errorBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(5)),
//                 borderSide: BorderSide(color: AppColor().red, width: 1)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(5)),
//                 borderSide: BorderSide(color: AppColor().black20, width: 1)),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(5)),
//                 borderSide: BorderSide(color: AppColor().black20, width: 1)),
//             suffixIcon: widget.icon != null
//                 ? suffixWidget()
//                 : widget.isPasswordField == true
//                     ? GestureDetector(
//                         onTap: widget.onSuffixTap,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 30.0),
//                           child: CommonImageWidget(
//                               width: 30,
//                               fit: BoxFit.fitWidth,
//                               imageSource: widget.isObscure
//                                   ? ImageConstants().eyesClose
//                                   : ImageConstants().eyesOpen,
//                               isNetworkImage: false),
//                         ),
//                       )
//                     : null),
//       ),
//     );
//   }

//   GestureDetector suffixWidget() {
//     return GestureDetector(
//       onTap: widget.onSuffixTap,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 30.0),
//         child: CommonImageWidget(
//             width: 30,
//             fit: BoxFit.fitWidth,
//             imageSource: widget.icon ?? "",
//             isNetworkImage: false),
//       ),
//     );
//   }
// }
