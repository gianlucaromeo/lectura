import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lectura/app.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/network_info.dart';
import 'package:lectura/firebase_options.dart';
import 'package:lectura/core/app_env.dart';
import 'package:lectura/providers/environment_provider.dart';
import 'package:lectura/providers/logger.dart';
import 'package:lectura/providers/network_info_provider.dart';
import 'package:lectura/providers/shared_prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (kDebugMode) {
    prefs.logAll();
  }

  final container = _initProviderContainer(
    environment,
    prefs,
  );

  runApp(
    ProviderScope(
      parent: container,
      child: App(),
    ),
  );
}

ProviderContainer _initProviderContainer(
  AppEnvironment environment,
  SharedPreferences prefs,
) {
  final container = ProviderContainer(
    overrides: [
      environmentInfoProvider.overrideWith(
        (ref) => EnvironmentInfo(environment),
      ),
      networkInfoProvider.overrideWith(
        (ref) => NetworkInfoImpl(
          InternetConnectionChecker.createInstance(),
        ),
      ),
    ],
    observers: [
      ProvidersLogger(),
    ],
  );

  container.read(appSharedPreferencesProvider.notifier).initialize(prefs);

  return container;
}
