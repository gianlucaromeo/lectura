import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';

class AuthBottomBar extends StatelessWidget {
  const AuthBottomBar({super.key});

  @override
  Widget build(BuildContext context) {

    const themeMode = ThemeMode.dark; // TODO Fetch

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
              // TODO Update
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
