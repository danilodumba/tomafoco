import 'package:event_bus/event_bus.dart';
import 'package:tomafoco/providers.dart';

class PomodoreService {
  static PomodoreService instance = PomodoreService();

  void addEvent(String event) {
    getIt<EventBus>().fire(event);
  }
}
