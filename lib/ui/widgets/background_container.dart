import 'package:flutter/material.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 1051 on 7/15/2021
/// Purpose : This is a background common container class used to show
/// background wherever required.

class BackgroundContainer extends StatefulWidget {
  const BackgroundContainer(
      {Key? key, this.height, this.width, this.backgroundColor})
      : super(key: key);
  final double? height;
  final double? width;
  final Color? backgroundColor;

  @override
  _BackgroundContainerState createState() => _BackgroundContainerState();
}

class _BackgroundContainerState extends State<BackgroundContainer> {
  @override
  Widget build(BuildContext context) => Container(
        width: widget.width,
        height: widget.height,
        color: widget.backgroundColor,
      );
}
