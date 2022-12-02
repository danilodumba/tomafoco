import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class BackgroundService {
  static const taskName = 'com.ddstech.tomafoco.timer';

  static final BackgroundService instance = BackgroundService();

  final _service = FlutterBackgroundService();

  void startService() async {
    var isRunning = await _service.isRunning();
    if (!isRunning) {
      _service.invoke("setAsBackground");
      _service.startService();
    }
  }

  void stopService() async {
    var isRunning = await _service.isRunning();
    if (isRunning) {
      _service.invoke("stopService");
    }
  }

  Future<void> initializeService() async {
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      service.invoke(
        'update',
      );
    });

    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      service.invoke(
        'update',
      );
    });
  }
}
