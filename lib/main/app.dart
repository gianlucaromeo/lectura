import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lectura/providers/environment_provider.dart';
import 'package:lectura/router/app_router.dart';

class App extends ConsumerWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environmentInfo = ref.read(environmentInfoProvider);

    return MaterialApp.router(
      title: 'Lectura',
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
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
