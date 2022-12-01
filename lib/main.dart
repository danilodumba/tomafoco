import 'package:flutter/material.dart';
import 'package:tomafoco/pages/home_page.dart';
import 'package:tomafoco/providers.dart';
import 'package:tomafoco/services/background_service.dart';
import 'package:tomafoco/services/notification_service.dart';
import 'package:tomafoco/themes/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  NotificationService().requestIOSPermissions();
  await BackgroundService().initializeService();
  setupProviders();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tomafoco',
      theme: defaultTheme(),
      home: HomePage(
        key: key,
      ),
    );
  }
}
