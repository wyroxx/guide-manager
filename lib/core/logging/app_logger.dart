import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final appLoggerProvider = Provider<AppLogger>((ref) => AppLogger.instance);

class AppLogger {
  AppLogger._()
    : _logger = Logger(printer: SimplePrinter(colors: false, printTime: false));

  static final AppLogger instance = AppLogger._();

  final Logger _logger;

  void debug(String scope, String message) {
    _logger.d('[$scope] $message');
  }

  void info(String scope, String message) {
    _logger.i('[$scope] $message');
  }

  void warning(
    String scope,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w('[$scope] $message', error: error, stackTrace: stackTrace);
  }

  void error(
    String scope,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e('[$scope] $message', error: error, stackTrace: stackTrace);
  }

  void fatal(
    String scope,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.f('[$scope] $message', error: error, stackTrace: stackTrace);
  }
}
