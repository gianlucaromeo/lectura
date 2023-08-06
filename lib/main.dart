import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lectura/firebase_options.dart';
import 'package:lectura/main/app_env.dart';
import 'package:lectura/providers/environment_provider.dart';
import 'package:lectura/providers/logger.dart';
import 'package:lectura/providers/theme_provider.dart';

import 'main/app.dart';

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      overrides: [
        environmentInfoProvider.overrideWith(
          (ref) => EnvironmentInfo(environment),
        ),
      ],
      observers: [
        ProvidersLogger(),
      ],
      child: App(),
    ),
  );
}
