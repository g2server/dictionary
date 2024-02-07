import 'package:dictionary/shared/logging/app_logger.dart';
import 'package:logger/logger.dart';

class PrettyLogger extends AppLogger {
  @override
  Future<void> init() async {
    logger = Logger();
  }

  late Logger logger;
  @override
  void d(String message) {
    logger.d(message);
  }

  @override
  void e(String message) {
    logger.e(message);
  }

  @override
  void i(String message) {
    logger.i(message);
  }

  @override
  void t(String message) {
    logger.t(message);
  }

  @override
  void f(String message) {
    logger.f(message);
  }
}
