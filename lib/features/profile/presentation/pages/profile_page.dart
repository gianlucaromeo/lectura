import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LecturaPage(
      title: "***PROFILE",
      body: Column(
        children: [
          MaterialButton(
            child: const Text("***Logout"),
            onPressed: () {
              context.read<LoginBloc>().add(UserLoggedOut());
            },
          ),
          MaterialButton(
            child: const Text("***Delete account"),
            onPressed: () {
              context.read<LoginBloc>().add(UserDeleteAccountRequested());
            },
          ),
        ],
      ),
    );
  }
}
