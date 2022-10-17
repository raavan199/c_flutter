import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../themes/custom_text_style.dart';
import 'custom_network_image.dart';

/// Created by Dev 1051 on 9/2/2021
/// Modified by Dev 1051 on 9/2/2021
/// Purpose : This is a gallery view where we will be able to show list of
/// images with max count at last image if it increase size.
class GalleryWithMaxCount extends StatefulWidget {
  const GalleryWithMaxCount({
    required this.urls,
    required this.maxCount,
    required this.onMediaError,
    Key? key,
  }) : super(key: key);
  final List<String> urls;
  final int maxCount;
  final Function(int) onMediaError;

  @override
  _GalleryWithMaxCountState createState() => _GalleryWithMaxCountState();
}

class _GalleryWithMaxCountState extends State<GalleryWithMaxCount> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => index >= widget.maxCount
          ? const SizedBox.shrink()
          : getSingleImageItem(
              index: index,
              url: widget.urls[index],
              shallShowMaxCount: index + 1 == widget.maxCount &&
                  widget.urls.length > widget.maxCount,
              count: widget.urls.length - widget.maxCount),
      separatorBuilder: (context, index) => const SizedBox(
            width: 8,
          ),
      itemCount: widget.urls.length);

  Widget getSingleImageItem({
    required String url,
    required bool shallShowMaxCount,
    required int count,
    required int index,
  }) =>
      Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 50,
              height: 50,
              color: AppColors.white,
              child: CustomNetworkImage(
                url: url,
                fit: BoxFit.fitWidth,
                displayLoader: true,
                isSmallNoImage: true,
                smallImageWidth: 45,
                onMediaError: () {
                  widget.onMediaError(index);
                },
              ),
            ),
          ),
          if (shallShowMaxCount)
            Positioned.fill(
              child: Align(
                child: Text(
                  "+$count",
                  style: CustomTextStyle.dialogTextStyle,
                ),
              ),
            )
          else
            const SizedBox.shrink()
        ],
      );
}
