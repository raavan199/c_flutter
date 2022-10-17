import 'package:flutter/material.dart';
import '../../exports/resources.dart';

import '../../exports/widgets.dart';

import 'svg_image_view.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 1051 on 7/15/2021
/// Purpose : This is the common svg button which will be used to provide svg
/// support with more configs.
class RoundCornerSvgButton extends StatefulWidget {
  const RoundCornerSvgButton({
    this.onClick,
    this.commonPadding = 16,
    this.radius = 100,
    this.borderColor = AppColors.black,
    this.assetName,
    this.allowDrawingOutsideViewBox = true,
    this.height = 27,
    this.borderWidth = 1,
    this.svgColor = AppColors.black,
    Key? key,
  }) : super(key: key);

  final Function? onClick;
  final double commonPadding;
  final double radius;
  final Color borderColor;
  final String? assetName;
  final bool allowDrawingOutsideViewBox;
  final double height;
  final double borderWidth;
  final Color svgColor;

  @override
  _RoundCornerSvgButtonState createState() => _RoundCornerSvgButtonState();
}

class _RoundCornerSvgButtonState extends State<RoundCornerSvgButton> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          if (widget.onClick != null) {
            widget.onClick!();
          }
        },
        child: Container(
          padding: EdgeInsets.all(widget.commonPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              border: Border.all(
                  width: widget.borderWidth, color: widget.borderColor)),
          child: SvgImageView(
              path: widget.assetName ?? "",
              allowDrawingOurside: widget.allowDrawingOutsideViewBox,
              height: widget.height,
              color: widget.svgColor),
        ),
      );
}
