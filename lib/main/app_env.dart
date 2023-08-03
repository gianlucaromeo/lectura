enum AppEnvironment {
  dev,
  staging,
  prod;
}

extension _EnvProperties on AppEnvironment {
  String get appTitle => switch (this) {
    AppEnvironment.dev => 'Lectura Dev',
    AppEnvironment.staging => 'Lectura Staging',
    AppEnvironment.prod => 'Lectura',
  };

  String get environmentName => name;
}

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.dev;

  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static AppEnvironment get environment => _environment;

  static String get appTitle => _environment.appTitle;

  static String get environmentName => _environment.environmentName;

  static bool get isProduction => _environment == AppEnvironment.prod;
}
