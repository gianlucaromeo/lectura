import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/providers/theme_provider.dart';

class AuthBottomBar extends ConsumerWidget {
  const AuthBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return  BottomAppBar(
      padding: 20.0.all,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              // TODO Add implementation
            },
            child: Text(
              context.l10n.auth__common__about_lectura,
            ),
          ),
          IconButton(
            onPressed: ref.read(appThemeModeProvider.notifier).toggleThemeMode,
            icon: themeMode == ThemeMode.dark
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
    );
  }
}
