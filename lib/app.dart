import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lectura/providers/environment_provider.dart';
import 'package:lectura/providers/theme_provider.dart';
import 'package:lectura/router/app_router.dart';
import 'package:lectura/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends ConsumerWidget {
   App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environmentInfo = ref.read(environmentInfoProvider);
    final appThemeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      title: "Lectura",
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      themeMode: appThemeMode,
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
