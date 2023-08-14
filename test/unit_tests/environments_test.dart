import 'package:flutter_test/flutter_test.dart';
import 'package:lectura/core/app_env.dart';

void main() {
  group("Environments", () {
   test("DEV", () {
     final envInfo = EnvironmentInfo(AppEnvironment.dev);

     expect(envInfo.appTitle, "Lectura DEV");
     expect(envInfo.name, "dev");
     expect(envInfo.isProduction, false);
   });

   test("STAGING", () {
     final envInfo = EnvironmentInfo(AppEnvironment.staging);

     expect(envInfo.appTitle, "Lectura STAGING");
     expect(envInfo.name, "staging");
     expect(envInfo.isProduction, false);
   });

   test("PRODUCTION", () {
     final envInfo = EnvironmentInfo(AppEnvironment.prod);

     expect(envInfo.appTitle, "Lectura");
     expect(envInfo.name, "prod");
     expect(envInfo.isProduction, true);
   });
  });
}