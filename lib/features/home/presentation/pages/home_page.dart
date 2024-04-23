import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LecturaPage(
      title: "***HOME PAGE",
      body: Column(
        children: [
          Text("***User: ${context.read<LoginBloc>().state.user?.email ?? ""}"),
          MaterialButton(
            child: const Text("***Profile"),
            onPressed: () {
              AutoRouter.of(context).push(Routes.profileRoute);
            },
          ),
        ],
      ),
    );
  }
}
