abstract class AppLogger {
  Future<void> init();

  void d(String message);
  void i(String message);
  void t(String message);
  void e(String message);
  void f(String message);
}
