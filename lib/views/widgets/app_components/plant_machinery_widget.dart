import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class PlantMachineryWidget extends StatelessWidget {
  PlantMachineryWidget(
      {super.key,
      this.onAdd,
      this.onDelete,
      this.uploadControllerList,
      this.count = 1,
      this.isDocument = false,
      this.uploadValidator,
      this.isReadOnly = false,
      this.onTap,
      this.onSuffixTap,
      this.isSummaryScreen = false,
      this.controllerList});
  final AppColor appColor = AppColor();
  final void Function()? onAdd;
  final void Function()? onDelete;
  final int count;
  final List<TextEditingController>? controllerList;
  final List<TextEditingController>? uploadControllerList;
  final bool isDocument;
  final void Function()? onTap;
  final void Function()? onSuffixTap;
  final StringConstants stringConstants = StringConstants();
  final ImageConstants imageConstants = ImageConstants();
  final String? Function(String?)? uploadValidator;
  final bool? isReadOnly;
  final bool? isSummaryScreen;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appColor.black05,
          border: Border.all(color: appColor.black20),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                  child: CommonTextWidget(
                    stringConstants.anyOtherPlant,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: appColor.black30),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              if (isReadOnly == false)
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColor.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: appColor.black20)),
                      child: CommonImageWidget(
                        imageSource: ImageConstants().plusIcon,
                        imageColor: appColor.darkGreen,
                        bgColor: appColor.white,
                        isNetworkImage: false,
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                width: 16,
              ),
              if (isReadOnly == false)
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColor.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: appColor.black20)),
                      child: CommonImageWidget(
                        imageSource: ImageConstants().deleteIcon,
                        imageColor: appColor.darkGreen,
                        bgColor: appColor.white,
                        isNetworkImage: false,
                      ),
                    ),
                  ),
                )
            ],
          ),
          ListView.builder(
            itemCount: controllerList?.length??0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
            // return  Container(width:300,height:100,child : Text("current index:: $index count :: $count :: normal controller :: ${controllerList?.length} >>>>> updaload list :: ${uploadControllerList?.length}"),);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: CommonTextFormFieldWidget(
                          isReadOnly: isReadOnly,
                          bgColor: appColor.white,
                          hintText: stringConstants.anyOtherPlant,
                          isMandatory: false,
                          controller: controllerList?[index] ??
                              TextEditingController()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 9, bottom: 18),
                      child: CommonTextFormFieldWidget(
                        hintText: stringConstants.upload,
                        isMandatory: false,
                        bgColor: appColor.white,
                        controller: uploadControllerList?[index] ??
                            TextEditingController(),
                        isDocument: isDocument,
                        isReadOnly: true,
                        disabledBgColor: isSummaryScreen == false
                            ? appColor.white
                            : appColor.black10,
                        icon: isReadOnly == false
                            ? (uploadControllerList?[index].text.isEmpty ??
                                    false
                                ? imageConstants.fileUpload
                                : imageConstants.removeIcon)
                            : null,
                        onTap: onTap,
                        onSuffixTap: onSuffixTap,
                        validator: uploadValidator,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
