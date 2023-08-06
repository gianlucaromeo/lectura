import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lectura/providers/environment_provider.dart';
import 'package:lectura/providers/theme_provider.dart';

@RoutePage()
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environmentInfo = ref.read(environmentInfoProvider);
    final appThemeMode = ref.read(appThemeModeProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(environmentInfo.appTitle)),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            appThemeMode.toggle();
          },
          child: const Text("Toggle theme"),
        ),
      ),
    );
  }
}
