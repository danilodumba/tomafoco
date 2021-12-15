import 'package:flutter/material.dart';
import 'package:tomafoco/controllers/home_controller.dart';
import 'package:tomafoco/entities/settings.dart';
import 'package:tomafoco/repositories/settings_repository.dart';

class SettingsController extends ChangeNotifier {
  static var instance = SettingsController();
  var repository = SettingsRepository();
  var homeController = HomeController.instance;
  Settings settings = Settings(pomodoroTime: 25, sleepTime: 5);

  Future set(Settings settings) async {
    await repository.set(settings);
    homeController.setSettings();
  }

  Future<Settings> get() async {
    settings = await repository.get();
    //notifyListeners();
    return settings;
  }

  Future setPomodoroTime(double pomodoroTime) async {
    settings.pomodoroTime = pomodoroTime.toInt();
    await set(settings);
  }

  Future setSleepTime(double sleepTime) async {
    settings.sleepTime = sleepTime.toInt();
    await set(settings);
  }
}
