import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupProviders() {
  getIt.registerSingleton<EventBus>(EventBus(sync: true));
}
