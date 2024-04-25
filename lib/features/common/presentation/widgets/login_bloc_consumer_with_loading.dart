import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/widgets/app_dialog.dart';

class LoginBlocConsumerWithLoading extends StatefulWidget {
  const LoginBlocConsumerWithLoading({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext, LoginState) builder;

  @override
  State<LoginBlocConsumerWithLoading> createState() =>
      _LoginBlocConsumerWithLoadingState();
}

class _LoginBlocConsumerWithLoadingState
    extends State<LoginBlocConsumerWithLoading> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.inProgress && !isLoading) {
          setState(() {
            isLoading = true;
          });
          showAppLoadingDialog(context);
        } else if (isLoading && state.status != LoginStatus.inProgress) {
          setState(() {
            isLoading = false;
          });
          AutoRouter.of(context).popForced(); // pop loading

          // If user is not logged in, show the auth page
          if (state.user == null || state.user?.id == null) {
            AutoRouter.of(context).popUntil((route) => route.isFirst);
            AutoRouter.of(context).replace(Routes.authRoute);
          }
        }
      },
      builder: widget.builder,
    );
  }
}
