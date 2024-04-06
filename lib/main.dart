import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/app.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/bloc/theme/theme_bloc.dart';
import 'package:lectura/firebase_options.dart';
import 'package:lectura/core/app_env.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Call this from one of the class of the "/main" folder
Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (kDebugMode) {
    prefs.logAll();
  }

  runApp(
    BlocProvider(
      create: (context) => ThemeBloc(),
      child: App(appEnvironment: environment),
    ),
  );
}
