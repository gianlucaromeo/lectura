import 'package:flutter/material.dart';
import 'package:lectura/main/app_env.dart';
import 'package:lectura/router/app_router.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lectura',
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      builder: (_, child) => EnvInfo.isProduction
          ? child!
          : Banner(
              location: BannerLocation.topEnd,
              message: EnvInfo.environmentName,
              child: child,
            ),
    );
  }
}
