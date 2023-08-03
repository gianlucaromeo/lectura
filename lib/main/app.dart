import 'package:flutter/material.dart';
import 'package:lectura/router/app_router.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lectura',
      routerConfig: _appRouter.config(),
    );
  }
}