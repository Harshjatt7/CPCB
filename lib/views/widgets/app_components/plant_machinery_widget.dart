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
      this.onTap,
      this.onSuffixTap,
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
            itemCount: count,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: CommonTextFormFieldWidget(
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
                        icon: uploadControllerList?[index].text.isEmpty ?? false
                            ? imageConstants.fileUpload
                            : imageConstants.removeIcon,
                        onTap: onTap,
                        onSuffixTap: onSuffixTap,
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
