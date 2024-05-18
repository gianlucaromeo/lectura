import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          context.read<LoginBloc>().add(LoginWithGoogleRequested());
        },
        icon: const Icon(Icons.g_mobiledata), // TODO Use Google's icon
        label: Text(context.l10n.auth__common__login_with_google),
      ),
    );
  }
}
