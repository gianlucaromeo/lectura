import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';

@RoutePage()
class LoginWrapperPage extends StatelessWidget {
  const LoginWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBlocConsumerWithLoading(
      builder: (context, state) {
        return const AutoRouter();
      },
    );
  }
}
