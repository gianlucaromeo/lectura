import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        // TODO Test
        if (state.user == null) {
          AutoRouter.of(context).popUntil((route) => route.isFirst);
          AutoRouter.of(context).replace(Routes.authRoute);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("***HOME PAGE"),
          ),
          body: Column(
            children: [
              Text("User: ${state.user?.email ?? ""}"),
              MaterialButton(
                child: const Text("Logout"),
                onPressed: () {
                  context.read<LoginBloc>().add(UserLoggedOut());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
