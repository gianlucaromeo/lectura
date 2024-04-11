import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/widgets/app_dialog.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        }

        if (isLoading && state.status != LoginStatus.inProgress) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop();
        }

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
