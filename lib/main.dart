import 'package:flutter/material.dart';
import 'package:lectura/main/app_env.dart';

import 'main/app.dart';

void main() => mainCommon(AppEnvironment.prod);

Future<void> mainCommon(AppEnvironment environment) async {
  EnvInfo.initialize(environment);
  runApp(App());
}