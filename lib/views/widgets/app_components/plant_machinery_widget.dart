import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_upload_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class PlantMachineryWidget extends StatelessWidget {
  PlantMachineryWidget({super.key});
  final AppColor appColor = AppColor();

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
                    "Any other plant machinery",
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
            itemCount: 1,
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
                          hintText: "Any other plant machinery",
                          isMandatory: false,
                          controller: TextEditingController()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: CommonDocumentField(
                        onTap: null,
                        label: "Upload",
                        bgColor: appColor.white,
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
