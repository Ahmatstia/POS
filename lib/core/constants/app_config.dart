/// Application-wide configuration constants.
abstract final class AppConfig {
  static const String appName = 'Lexa POS';
  static const int pinLength = 4;
  static const Duration pinLockTimeout = Duration(minutes: 5);
  static const bool useMockAuth = true;
}
