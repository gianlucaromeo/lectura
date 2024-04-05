import 'package:flutter/material.dart';
import 'package:lectura/core/app_env.dart';
import 'package:lectura/router/app_router.dart';
import 'package:lectura/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {

  App({super.key, required this.appEnvironment});

  final AppEnvironment appEnvironment;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final environmentInfo = EnvironmentInfo(appEnvironment); // TODO

    return MaterialApp.router(
      title: "Lectura",
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // TODO
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (_, child) => environmentInfo.isProduction
          ? child!
          : Banner(
              location: BannerLocation.topEnd,
              message: environmentInfo.name,
              child: child,
            ),
    );
  }
}
