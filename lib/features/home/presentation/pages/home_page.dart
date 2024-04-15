import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginBlocConsumerWithLoading(
      builder: (context, state) => LecturaPage(
        title: "***HOME PAGE",
        body: Column(
          children: [
            Text("***User: ${state.user?.email ?? ""}"),
            MaterialButton(
              child: const Text("***Profile"),
              onPressed: () {
                AutoRouter.of(context).push(Routes.profileRoute);
              },
            ),
          ],
        ),
        bottomNavigationBar: const AppBottomNavigationBar(
          currentPage: BottomBarCurrentPage.home,
        ),
      ),
    );
  }
}
