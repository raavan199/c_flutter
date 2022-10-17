import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_constants.dart';
import '../../exports/resources.dart';
import '../../exports/utilities.dart';
import '../../mixins/TimerSingleTon.dart';
import '../../services/shared_preference_service.dart';

/// Created by Dev 2301 on 12/14/2021
/// Modified by Dev 2301 on 12/14/2021
/// Purpose : floating timer widget displayed in common container
class TimerWidget extends StatefulWidget {
  TimerWidget({
    required this.startTimer,
    required this.cancelTimer,
    Key? key,
  }) : super(key: key);
  String time = "";
  final bool startTimer;
  final bool cancelTimer;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with TickerProviderStateMixin {
  late TimerSingleton timerSingleTon;

  @override
  void initState() {
    super.initState();
    timerSingleTon = TimerSingleton();
    if (widget.startTimer) {
      timerSingleTon.startTimer();
    } else {
      timerSingleTon.stopTimer();
    }
    timerSingleTon.setFunction((value) {
      if(!mounted){
        return;
      }
      setState(() {
        widget.time = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => _timerWidget();

  Widget _timerWidget() => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [Shadows.greyShadow],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        // width: 45,
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.icTimer,
                height: 15,
                // width: 25,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                widget.time,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: AppFonts.medium,
                ),
              ),
            ],
          ),
        ),
      );
}
