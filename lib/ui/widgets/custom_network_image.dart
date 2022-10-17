import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../exports/widgets.dart';

/// Created by Dev 2301 on 7/29/2021
/// Modified by Dev 2301 on 7/29/2021
/// Purpose : custom network image class
class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    required this.url,
    required this.onMediaError,
    this.fit = BoxFit.cover,
    this.displayLoader = false,
    this.errorPlaceHolder,
    this.isNoImage = false,
    this.isPlainBackground = false,
    this.isSmallNoImage = false,
    this.smallImageWidth = 50,
    Key? key,
  }) : super(key: key);

  final String? url;
  final BoxFit fit;
  final bool displayLoader;
  final String? errorPlaceHolder;
  final bool isNoImage;
  final double smallImageWidth;
  final bool isSmallNoImage;
  final Function() onMediaError;
  final bool isPlainBackground;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: url ?? "",
        fit: fit,
        placeholder: (context, url) =>
            displayLoader ? CustomLoader.small() : Container(),
        errorWidget: (context, url, error) {
          onMediaError();
          if (errorPlaceHolder != null &&
              (errorPlaceHolder?.contains("http") ?? false)) {
            return Image.network(
              errorPlaceHolder!,
              fit: BoxFit.cover,
            );
          } else {
            if (isNoImage) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    AppStrings.imageCurentlyNotAvailable,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.noDataContent,
                  )
                ],
              );
            } else if (isSmallNoImage) {
              return const Icon(Icons.image);
            } else if (isPlainBackground) {
              return Container(
                color: AppColors.black,
              );
            } else {
              return imagePlaceholder();
            }
          }
        },
      );
}

Widget imagePlaceholder() => const Icon(Icons.image);
