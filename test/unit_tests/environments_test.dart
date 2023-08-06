import 'package:flutter_test/flutter_test.dart';
import 'package:lectura/main/app_env.dart';

void main() {
  group("Environments", () {
   test("DEV", () {
     EnvInfo.initialize(AppEnvironment.dev);

     expect(EnvInfo.environment, AppEnvironment.dev);
     expect(EnvInfo.appTitle, "Lectura DEV");
     expect(EnvInfo.environmentName, "dev");
     expect(EnvInfo.isProduction, false);
   });

   test("STAGING", () {
     EnvInfo.initialize(AppEnvironment.staging);

     expect(EnvInfo.environment, AppEnvironment.staging);
     expect(EnvInfo.appTitle, "Lectura STAGING");
     expect(EnvInfo.environmentName, "staging");
     expect(EnvInfo.isProduction, false);
   });

   test("PRODUCTION", () {
     EnvInfo.initialize(AppEnvironment.prod);

     expect(EnvInfo.environment, AppEnvironment.prod);
     expect(EnvInfo.appTitle, "Lectura");
     expect(EnvInfo.environmentName, "prod");
     expect(EnvInfo.isProduction, true);
   });
  });
}