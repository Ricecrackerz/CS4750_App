import 'package:flutter/material.dart';
import 'package:cs4750_app/pomodoroModel.dart';

const pomodoroTotalTime = 25 * 60;
const shortBreakTime = 5 * 60;
const longBreakTime = 15 * 60;
const pomodoroPerSet = 4;

const Map<PomodoroModel, String> statusDescription = {
  PomodoroModel.timingPomodoro: 'Pomodoro is running, time to be focused',
  PomodoroModel.timingLongBreak: 'Relax during this long break.',
  PomodoroModel.timingShortBreak: 'Let\'s take a breather',
  PomodoroModel.pausedPomodoro: 'Start your pomodoro',
  PomodoroModel.pausedShortBreak: 'Short break paused',
  PomodoroModel.pausedLongBreak: 'Long break paused',
  PomodoroModel.finish: 'Congrats, pomodoro is finished',
};

const Map<PomodoroModel, MaterialColor> statusColor = {
  PomodoroModel.timingPomodoro: Colors.green,
  PomodoroModel.timingLongBreak: Colors.green,
  PomodoroModel.timingShortBreak: Colors.green,
  PomodoroModel.pausedPomodoro: Colors.orange,
  PomodoroModel.pausedShortBreak: Colors.orange,
  PomodoroModel.pausedLongBreak: Colors.orange,
  PomodoroModel.finish: Colors.red,
};