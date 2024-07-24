// import 'package:cpcb_tyre/theme/app_color.dart';
// import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
// import 'package:flutter/material.dart';

// class CommonMultilineTextFormField extends StatelessWidget {
//   final TextEditingController? controller;
//   final int? maxLines;
//   final int? maxLength;
//   final String? label;
//   final bool isMandatory;
//   final Color? bgColor;
//   final appColor = AppColor();
//   final String? Function(String?)? validator;
//   CommonMultilineTextFormField({
//     super.key,
//     this.maxLines,
//     this.maxLength,
//     this.controller,
//     this.bgColor,
//     this.label,
//     this.isMandatory = false,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       decoration: BoxDecoration(
//           color: bgColor,
//           border: Border.all(
//             color: appColor.black20,
//           ),
//           borderRadius: BorderRadius.circular(5)),
//       child: TextFormField(
//         focusNode: FocusNode(canRequestFocus: true),
//         validator: validator,
//         controller: controller,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         maxLength: maxLength ?? 100,
//         maxLines: maxLines,
//         cursorColor: appColor.black50,
//         keyboardType: TextInputType.multiline,
//         style: Theme.of(context).textTheme.labelSmall?.copyWith(
//               color: appColor.black90,
//               letterSpacing: 1,
//             ),
//         decoration: InputDecoration(
//           counter: const Offstage(),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.only(top: 0, bottom: 4),
//           label: RichText(
//             text: WidgetSpan(
//               child: Row(children: [
//                 CommonTextWidget(
//                   label ?? "",
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelSmall
//                       ?.copyWith(color: appColor.grey01, height: 1),
//                 ),
//                 CommonTextWidget(
//                   isMandatory == true ? " *" : '',
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelSmall
//                       ?.copyWith(color: appColor.red, height: 1),
//                 )
//               ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
