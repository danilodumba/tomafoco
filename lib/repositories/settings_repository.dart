import 'package:tomafoco/entities/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  Future set(Settings settings) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("pomodoroTime", settings.pomodoroTime);
    prefs.setInt("sleepTime", settings.sleepTime);
  }

  Future<Settings> get() async {
    var prefs = await SharedPreferences.getInstance();
    int pomodoroTime = prefs.getInt("pomodoroTime") ?? 25;
    int sleepTime = prefs.getInt("sleepTime") ?? 5;

    return Settings(pomodoroTime: pomodoroTime, sleepTime: sleepTime);
  }
}
