import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../theme/app_color.dart';

/// [CommonImageWidget] will be used as a common image display widget.
/// [imageSource] can be [network], [asset] and [svg] image types.
class CommonImageWidget extends StatelessWidget {
  final Color? bgColor;
  final String imageSource;

  final bool? isNetworkImage;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Color? imageColor;

  const CommonImageWidget(
      {super.key,
      this.bgColor,
      required this.imageSource,
      required this.isNetworkImage,
      this.borderRadius,
      this.fit,
      this.height,
      this.width,
      this.imageColor});

  @override
  Widget build(BuildContext context) {
    bool isSvg = false;

    imageSource.split(".").last.contains("svg") ? isSvg = true : null;
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        color: bgColor ?? AppColor().white,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: isNetworkImage == true
            ? isSvg == true
                ? SvgPicture.network(
                    imageSource,
                    fit: fit ?? BoxFit.fill,
                    height: height,
                    width: width,
                    placeholderBuilder: (context) {
                      return imageHelperContainer(
                          context, Icons.image_outlined);
                    },
                  )
                : CachedNetworkImage(
                    imageUrl: imageSource,
                    fit: fit ?? BoxFit.fill,
                    height: height,
                    width: width,
                    errorWidget: (context, url, error) {
                      return imageHelperContainer(
                          context, Icons.image_not_supported_outlined);
                    },
                    placeholder: (context, placeholder) {
                      return imageHelperContainer(
                          context, Icons.image_outlined);
                    },
                  )
            : isSvg == true
                ? SvgPicture.asset(
                    imageSource,
                    height: height,
                    width: width,
                    fit: fit ?? BoxFit.fill,
                  )
                : Image.asset(
                    imageSource,
                    height: height,
                    width: width,
                    color: imageColor,
                    fit: fit ?? BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return imageHelperContainer(
                          context, Icons.image_not_supported_outlined);
                    },
                  ),
      ),
    );
  }

  Container imageHelperContainer(BuildContext context, IconData icon) {
    return Container(
      height: height,
      width: width,
      color: AppColor().white,
      child: Icon(
        icon,
        color: AppColor().white,
        size: 30,
      ),
    );
  }
}
