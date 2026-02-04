import 'environment.dart';

class AppConfig {
  final Environment environment;
  // final String appName;

  static late AppConfig instance;

  AppConfig({required this.environment,
    // required this.appName
  });

  static void init(AppConfig config) {
    instance = config;
  }
}
