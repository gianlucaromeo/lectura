
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/data/data_providers.dart';
import 'package:lectura/features/auth/domain/domain_providers.dart';
import 'package:lectura/features/auth/presentation/providers/auth_use_cases_provider.dart';
import 'package:lectura/features/auth/presentation/widgets/auth_bottom_bar.dart';
import 'package:lectura/features/auth/presentation/widgets/registration_form.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/providers/network_info_provider.dart';

@RoutePage()
class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage>
    with SingleTickerProviderStateMixin {
  late final TabController? tabController;

  @override
  void initState() {
    super.initState();

    final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
    final networkInfo = ref.read(networkInfoProvider);

    final authRepository = ref.read(authRepositoryProvider(
      authRemoteDataSource,
      networkInfo,
    ));

    ref.read(authUseCasesProvider.notifier).initialize(authRepository);

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
