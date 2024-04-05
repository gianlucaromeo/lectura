import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/presentation/widgets/auth_bottom_bar.dart';
import 'package:lectura/features/auth/presentation/widgets/registration_form.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late final TabController? tabController;


  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 1,
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LecturaPage(
      title: context.l10n.app__title,
      padding: [20.0, 20.0, 20.0, 0.0].fromLTRB,
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: context.l10n.auth__tab__login),
              Tab(text: context.l10n.auth__tab__signup),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                const Text("Login"),
                Padding(
                  padding: [20.0, 0.0, 20.0, 0.0].fromLTRB,
                  child: const RegistrationForm(),
                ),
              ],
            ),
          ),
          20.0.verticalSpace,
        ],
      ),
      bottomNavigationBar: const AuthBottomBar(),
    );
  }
}
