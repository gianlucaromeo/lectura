import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/bloc/theme/theme_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/app_dialog.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return LecturaPage(
      title: context.l10n.profile_page__title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loginBloc.state.user!.email!),
            25.0.verticalSpace,
            OutlinedButton(
              child: Text(context.l10n.profile_page__logout),
              onPressed: () {
                loginBloc.add(UserLoggedOut());
              },
            ),
            15.0.verticalSpace,
            OutlinedButton(
              child: Text(
                context.l10n.profile_page__delete_account,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onPressed: () {
                showAppConfirmationDialog(
                  context: context,
                  title: context.l10n.dialog__delete_account__title,
                  content: context.l10n.dialog__delete_account__content,
                  confirmationOption: context.l10n.dialog__delete_account__confirm_option,
                  denyOption: context.l10n.dialog__delete_account__deny_option,
                  onConfirm: () {
                    loginBloc.add(UserDeleteAccountRequested(
                      userId: context
                          .read<LoginBloc>()
                          .state
                          .user!
                          .id!,
                    ));
                  },
                  onDeny: () {},
                );
              },
            ),
            25.0.verticalSpace,
            IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ThemeToggled());
              },
              icon: context.watch<ThemeBloc>().state.currentThemeMode ==
                      ThemeMode.dark
                  ? const Icon(Icons.light_mode_outlined)
                  : const Icon(Icons.dark_mode_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
