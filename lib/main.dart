import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lectura/firebase_options.dart';
import 'package:lectura/main/app_env.dart';

import 'main/app.dart';

Future<void> mainCommon(AppEnvironment environment) async {
  EnvInfo.initialize(environment);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}