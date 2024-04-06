import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/bloc/theme/theme_bloc.dart';

class AuthBottomBar extends StatelessWidget {
  const AuthBottomBar({super.key});

  @override
  Widget build(BuildContext context) {

    final themeMode = context.watch<ThemeBloc>().state.currentThemeMode;

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
            onPressed: () {
              context.read<ThemeBloc>().add(ThemeToggled());
            },
            icon: themeMode == ThemeMode.dark
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
    );
  }
}
