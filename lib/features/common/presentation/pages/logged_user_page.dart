import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/routes.dart';

@RoutePage()
class LoggedUserPage extends StatelessWidget {
  const LoggedUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        Routes.homeRoute,
        Routes.searchRoute,
        Routes.libraryRoute,
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: context.l10n.bottom_bar__home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: context.l10n.bottom_bar__search,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.book),
              label: context.l10n.bottom_bar__library,
            ),
          ],
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
