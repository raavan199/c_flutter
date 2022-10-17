import 'dart:async';

import 'package:flutter/material.dart';

class TimerSingleton {
  static final TimerSingleton _singleton = TimerSingleton._internal();
  String lastTime = '', totalTime = '';
  static Timer? timer;
  static bool punchInCall = false;
  int timerValue = 0;
  bool isTimerRunning = false;
  late Function yesOnPressed;
  late ValueSetter<String> onPressed;

  factory TimerSingleton() {
    return _singleton;
  }

  setFunction(Function timerUpdate){
    yesOnPressed=timerUpdate;
  }
  startTimer() {
    if (isTimerRunning) {
      return;
    }else{
      timerValue = 0;
      totalTime="";
      isTimerRunning=true;
    }
    timer =
        Timer.periodic(const Duration(milliseconds: 1000), updateTimerValue);
  }

  resetTimer(){
    timerValue = 0;
    totalTime="";
  }

  stopTimer() {
    isTimerRunning=false;
    timerValue = 0;
    totalTime="";
    if (timer != null) {
      timer!.cancel();
    }
  }

  updateTimerValue(Timer t) {
    if(!isTimerRunning){
      return;
    }
    timerValue++;
    totalTime = transformMilliSeconds(timerValue * 1000);
    yesOnPressed(totalTime);
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  TimerSingleton._internal();
}
