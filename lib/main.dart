import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/app/app.dart';
import 'package:guide_manager/app/theme_controller.dart';
import 'package:guide_manager/core/logging/app_logger.dart';
import 'package:guide_manager/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = AppLogger.instance;

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.fatal(
      'Flutter',
      'Uncaught framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.fatal(
      'Dart',
      'Uncaught asynchronous error',
      error: error,
      stackTrace: stackTrace,
    );
    return true;
  };

  try {
    logger.info('Bootstrap', 'Initializing Firebase');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{themeModePreferenceKey},
      ),
    );

    logger.info('Bootstrap', 'Application initialized');
    runApp(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
        child: const GuideApp(),
      ),
    );
  } catch (error, stackTrace) {
    logger.fatal(
      'Bootstrap',
      'Application initialization failed',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
}
