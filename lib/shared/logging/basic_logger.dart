import 'package:dictionary/shared/logging/app_logger.dart';
import 'package:flutter/material.dart';

class BasicLogger extends AppLogger {
  @override
  Future<void> init() {
    return Future.value();
  }

  @override
  void d(String message) {
    message = 'DEBUG: $message';
    debugPrint(message);
  }

  @override
  void e(String message) {
    message = 'ERROR: $message';
    debugPrint(message);
  }

  @override
  void t(String message) {
    message = 'TRACE: $message';
    debugPrint(message);
  }

  @override
  void f(String message) {
    message = 'FATAL: $message';
    debugPrint(message);
  }

  @override
  void i(String message) {
    message = 'INFO: $message';
    debugPrint(message);
  }
}
