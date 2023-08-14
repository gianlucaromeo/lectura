enum AppEnvironment {
  dev,
  staging,
  prod;
}

extension on AppEnvironment {
  String get appTitle => switch (this) {
    AppEnvironment.dev => 'Lectura DEV',
    AppEnvironment.staging => 'Lectura STAGING',
    AppEnvironment.prod => 'Lectura',
  };

  String get environmentName => name;
}

class EnvironmentInfo {
  EnvironmentInfo(AppEnvironment environment) {
    _environment = environment;
  }

  late final AppEnvironment _environment;

  String get appTitle => _environment.appTitle;
  String get name => _environment.environmentName;
  bool get isProduction => _environment == AppEnvironment.prod;
}