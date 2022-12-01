import 'package:tomafoco/entities/pomodore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PomodoreRepository {
  Future save(Pomodore pomodore) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("pomodoro", pomodore.toString());
    prefs.reload();
  }

  Future<Pomodore> get() async {
    var prefs = await SharedPreferences.getInstance();
    int timer = prefs.getInt("pomodoro_timer") ?? 25;
    int timeLeft = prefs.getInt("pomodoro_time_left") ?? 25;

    return Pomodore(timer, timeLeft, DateTime.now().day);
  }
}
