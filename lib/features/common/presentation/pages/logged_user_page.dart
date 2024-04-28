import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class LoggedUserPage extends StatelessWidget {
  const LoggedUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BrowseBloc>().add(FetchUserBooksRequested(
      context.read<LoginBloc>().state.user!.id!,
    ));

    return AutoTabsScaffold(
      routes: [
        Routes.libraryWrapperRoute,
        Routes.searchWrapperRoute,
        Routes.profileRoute,
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        log(
          "Current index: ${tabsRouter.activeIndex}, route: ${tabsRouter.currentPath}",
          name: "LoggedUserPage",
        );

        log(
          "Stack ${tabsRouter.stack.map((e) => e.name)}",
          name: "LoggedUserPage",
        );

        return tabsRouter.currentPath.endsWith("/book")
            ? 0.0.verticalSpace
            : BottomNavigationBar(
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.book),
                    label: context.l10n.bottom_bar__library,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.search),
                    label: context.l10n.bottom_bar__search,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: context.l10n.bottom_bar__profile,
                  ),
                ],
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
              );
      },
    );
  }
}
