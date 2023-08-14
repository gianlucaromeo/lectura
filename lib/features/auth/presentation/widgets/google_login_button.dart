import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {}, // TODO Add implementation
        icon: const Icon(Icons.g_mobiledata), // TODO Use Google's icon
        label: Text(context.l10n.auth__common__login_with_google),
      ),
    );
  }
}
