import 'package:flutter/material.dart';

import '../../exports/themes.dart';

/// Created by Dev 2301 on 8/14/2021
/// Modified by Dev 2301 on 8/14/2021
/// Purpose : widget to display char counter
class TextCounter extends StatelessWidget {
  const TextCounter({
    required this.count,
    required this.limit,
    Key? key,
  }) : super(key: key);

  final int count;
  final int limit;

  @override
  Widget build(BuildContext context) => Text(
      "$count/$limit",
      style: count > limit
          ? CustomTextStyle.remainingCharacterStyle
          : CustomTextStyle.textCounterStyle,
    );
}
