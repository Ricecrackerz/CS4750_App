import 'dart:async';

import 'package:cs4750_app/main.dart';
import 'package:cs4750_app/pomodoroConstants.dart';
import 'package:cs4750_app/pomodoroModel.dart';
import 'package:cs4750_app/widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Pomodoro extends StatefulWidget {

  @override
  _PomodoroState createState() => _PomodoroState();
}

const _btnTextStart = 'START POMODORO';
const _btnTextStartNew = 'START NEW SET';
const _btnTextResumePomodoro = 'RESUME POMODORO';
const _btnTextResumeBreak = 'RESUME BREAK';
const _btnTextStartShortBreak = 'TAKE SHORT BREAK';
const _btnTextStartLongBreak = 'TAKE LONG BREAK';
const _btnTextPause = 'PAUSE';
const _btnTextReset = 'RESET';

class _PomodoroState extends State<Pomodoro> {
  int remainingTime = pomodoroTotalTime;
  String mainBtnText = _btnTextStart;
  PomodoroModel pomodoroModel = PomodoroModel.pausedPomodoro;
  Timer _timer;
  int pomodoroNum = 0;
  int pomodoroSet = 0;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFAF9F9),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Pomodoro Count: $pomodoroNum",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF555B6E),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Set: $pomodoroSet",
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF555B6E),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 220.0,
                      lineWidth: 15.0,
                      percent: _getPomodoroPercentage(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        _secondsToString(remainingTime),
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF555B6E),
                      ),
                      ),
                      progressColor: statusColor[pomodoroModel],
                    ),
                    SizedBox(height: 10,),
                    ProgressIcons(
                      total: pomodoroPerSet,
                      done: pomodoroNum - (pomodoroSet * pomodoroPerSet),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        statusDescription[pomodoroModel],
                      style: TextStyle(
                        color: Color(0xFF555B6E),
                      ),
                    ),
                    PomodoroButton(
                      onTap: _mainButtonPressed,
                      text: mainBtnText,
                    ),
                    PomodoroButton(
                      onTap: _resetButton,
                      text: _btnTextReset,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _secondsToString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - (roundedMinutes * 60);
    String remainingSecondsString;

    if(remainingSeconds < 10){
      remainingSecondsString = '0$remainingSeconds';
    }else {
      remainingSecondsString = remainingSeconds.toString();
    }

    return '$roundedMinutes:$remainingSecondsString';
  }

  _getPomodoroPercentage() {
    int totalTime;
    switch(pomodoroModel) {

      case PomodoroModel.timingPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroModel.pausedPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroModel.timingShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroModel.pausedShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroModel.timingLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroModel.pausedLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroModel.finish:
        totalTime = pomodoroTotalTime;
        break;
    }

    double percentage = (totalTime - remainingTime) / totalTime;
    return percentage;
  }

  _mainButtonPressed() {
    switch(pomodoroModel) {
      case PomodoroModel.pausedPomodoro:
        _startPomodoroCountdown();
        break;
      case PomodoroModel.timingPomodoro:
        _pausePomodoroCountdown();
        break;
      case PomodoroModel.timingShortBreak:
        _pauseShortBreakCountdown();
        break;
      case PomodoroModel.pausedShortBreak:
        _startShortBreak();
        break;
      case PomodoroModel.timingLongBreak:
        _pauseLongBreakCountdown();
        break;
      case PomodoroModel.pausedLongBreak:
        _startLongBreak();
        break;
      case PomodoroModel.finish:
        pomodoroSet ++;
        _startPomodoroCountdown();
        break;
    }
  }

  void _startPomodoroCountdown () {
    pomodoroModel = PomodoroModel.timingPomodoro;
    if(_timer != null){
      _timer.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) => {
      if(remainingTime > 0) {
        setState(() {
          remainingTime--;
          mainBtnText = _btnTextPause;
        })
      } else {
        _playSound(),
        pomodoroNum++,
        _cancelTimer(),
        if(pomodoroNum % pomodoroPerSet == 0){
          pomodoroModel = PomodoroModel.pausedLongBreak,
          setState(() {
            remainingTime = longBreakTime;
            mainBtnText = _btnTextStartLongBreak;
          }),
        } else {
          pomodoroModel = PomodoroModel.pausedShortBreak,
          setState(() {
            remainingTime = shortBreakTime;
            mainBtnText = _btnTextStartShortBreak;
          }),
        }
      }
    });
  }

  _pausePomodoroCountdown() {
    pomodoroModel = PomodoroModel.pausedPomodoro;
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumePomodoro;
    });
  }

  _resetButton() {
    pomodoroNum = 0;
    pomodoroSet = 0;
    _cancelTimer();
    _stopCountdown();
  }

  _stopCountdown() {
    pomodoroModel = PomodoroModel.pausedPomodoro;
    setState(() {
      mainBtnText = _btnTextStart;
      remainingTime = pomodoroTotalTime;
    });
  }

  _startShortBreak() {
    pomodoroModel = PomodoroModel.timingShortBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(
      Duration(seconds: 1),
        (timer) => {
          if(remainingTime > 0){
            setState(() {
              remainingTime--;
            }),
          }else {
            _playSound(),
            remainingTime = pomodoroTotalTime,
            _cancelTimer(),
            pomodoroModel = PomodoroModel.pausedPomodoro,
            setState(() {
              mainBtnText = _btnTextStart;
            }),
          }
        }
    );
  }

  _startLongBreak() {
    pomodoroModel = PomodoroModel.timingLongBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(
        Duration(seconds: 1),
            (timer) => {
        if(remainingTime > 0){
        setState(() {
      remainingTime--;
    }),
    }else {
    _playSound(),
    remainingTime = pomodoroTotalTime,
    _cancelTimer(),
    pomodoroModel = PomodoroModel.finish,
    setState(() {
    mainBtnText = _btnTextStartNew;
    }),
    }
  }
    );
  }

  _pauseShortBreakCountdown(){
    pomodoroModel = PomodoroModel.pausedShortBreak;
    _pausedBreakCountdown();
  }

  _pauseLongBreakCountdown(){
    pomodoroModel = PomodoroModel.pausedLongBreak;
    _pausedBreakCountdown();
  }

  _pausedBreakCountdown() {
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumeBreak;
    });
  }

  _cancelTimer() {
    if(_timer != null){
      _timer.cancel();
    }
  }

  _playSound() {
  }
}
