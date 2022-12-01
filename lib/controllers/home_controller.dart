import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:tomafoco/entities/pomodore.dart';
import 'package:tomafoco/entities/settings.dart';
import 'package:tomafoco/providers.dart';
import 'package:tomafoco/repositories/pomodore_repository.dart';
import 'package:tomafoco/repositories/settings_repository.dart';
import 'package:tomafoco/services/background_service.dart';
import 'package:tomafoco/services/notification_service.dart';
import 'package:tomafoco/themes/colors.dart';

class HomeController extends ChangeNotifier {
  static const taskName = 'com.ddstech.tomafoco.timer';
  int currentTimeSeconds = 30;
  int totalTimeSeconds = 30;
  Timer? _timer;
  bool isWorking = true;
  bool isPaused = false;
  bool isStoped = true;
  static var instance = HomeController();
  var settingsRepository = SettingsRepository();
  var pomodoreRepository = PomodoreRepository();
  var backgroundService = BackgroundService();
  Settings? settings;

  HomeController() {
    setSettings();

    FlutterBackgroundService().on('update').listen((event) {
      timerTest();
    });

    // getIt<EventBus>().on().listen((event) {
    //   print("Tempo decorrido -> $event");
    // });
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

  void setTimerLeft(int timerLeft) {
    currentTimeSeconds = timerLeft;
  }

  void startTimer() async {
    // const oneSec = Duration(
    //   seconds: 1,
    // );
    // _timer = Timer.periodic(
    //   oneSec,
    //   timerTest,
    // );

    // var pomodore =
    //     Pomodore(settings?.pomodoroTime ?? 10, 0, DateTime.now().day);
    // await pomodoreRepository.save(pomodore);

    //timerTest();
    backgroundService.startService();
    FlutterBackgroundService().invoke("setAsBackground");
  }

  void timerTest() {
    if (currentTimeSeconds == 0) {
      NotificationService().showNotifications(
        isWorking ? "Boa!! Pomodoro finalizado." : "Bora pro foco!",
        isWorking
            ? "Pegue uma pausa para descanso!!"
            : "Está indo muito bem!!!",
      );
      cancelTimer();
    } else {
      currentTimeSeconds--;
      notifyListeners();
    }
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }

    backgroundService.stopService();

    nextSteep();
  }

  void pauseTimer() {
    _timer?.cancel();
    isPaused = true;
    isStoped = false;
    backgroundService.stopService();

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
    return isWorking ? 'Bora pro foco!!!!' : 'Dê uma relaxada...';
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
