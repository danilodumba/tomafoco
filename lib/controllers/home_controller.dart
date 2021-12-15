import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomafoco/entities/settings.dart';
import 'package:tomafoco/repositories/settings_repository.dart';
import 'package:tomafoco/services/notification_service.dart';
import 'package:tomafoco/themes/colors.dart';

class HomeController extends ChangeNotifier {
  int currentTimeSeconds = 30;
  int totalTimeSeconds = 30;
  Timer? _timer;
  bool isWorking = true;
  bool isPaused = false;
  bool isStoped = true;
  static var instance = HomeController();
  var settingsRepository = SettingsRepository();
  Settings? settings;

  HomeController() {
    setSettings();
  }

  setSettings() {
    settingsRepository.get().then((value) {
      settings = value;
      if (isWorking) {
        setWorking();
      } else {
        setBreak();
      }

      notifyListeners();
    });
  }

  Color getColor() {
    return isWorking ? LightColors.ligthRed : LightColors.kGreen;
  }

  void startTimer() {
    const oneSec = Duration(
      seconds: 1,
    );
    _timer = Timer.periodic(
      oneSec,
      (_timer) {
        if (currentTimeSeconds == 0) {
          NotificationService().showNotifications(
            isWorking ? "Boa!! Pomodoro finalizado." : "Bora pro foco!",
            isWorking
                ? "Pegue uma pausa para descanso!!"
                : "Ta indo bem pra caralho!!!",
          );
          cancelTimer();
        } else {
          currentTimeSeconds--;
          notifyListeners();
        }
      },
    );
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }

    nextSteep();
  }

  void pauseTimer() {
    _timer?.cancel();
    isPaused = true;
    isStoped = false;
    notifyListeners();
  }

  void initTimer() {
    if (_timer != null && _timer!.isActive) {
      return;
    }
    isPaused = false;
    isStoped = false;

    startTimer();
  }

  void nextSteep() {
    isWorking = !isWorking;
    isStoped = true;
    isPaused = false;

    if (isWorking) {
      setWorking();
    } else {
      setBreak();
    }
    notifyListeners();
  }

  void setWorking() {
    totalTimeSeconds = currentTimeSeconds = settings?.pomodoroTime ?? 25;
    currentTimeSeconds = totalTimeSeconds = totalTimeSeconds * 60;
  }

  void setBreak() {
    totalTimeSeconds = currentTimeSeconds = settings?.sleepTime ?? 5;
    totalTimeSeconds = currentTimeSeconds = currentTimeSeconds * 60;
  }

  String getDescription() {
    return isWorking ? 'Borah pro foco!!!!' : 'Dê uma relaxada...';
  }

  double getPercent() {
    return ((currentTimeSeconds * 100) / totalTimeSeconds) / 100;
  }

  String getFormatedTime() {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = currentTimeSeconds ~/ 60;
    int sec = currentTimeSeconds % 60;

    String parsedTime =
        getParsedTime(min.toString()) + ":" + getParsedTime(sec.toString());

    return parsedTime;
  }

  String getTotalMinutes() {
    double total = this.totalTimeSeconds / 60;

    return total.toInt().toString() + " min.";
  }
}
