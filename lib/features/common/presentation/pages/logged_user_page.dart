import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';
import 'package:lectura/features/common/data/datasources/user_books_datasource.dart';
import 'package:lectura/features/common/data/repositories/user_books_repository.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/features/search/data/repositories/search_repository.dart';

@RoutePage()
class LoggedUserPage extends StatelessWidget {
  const LoggedUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final googleApiDataSource = GoogleApiDataSource();

    final searchRepository = SearchRepositoryImpl(
      googleApiDataSource,
    );

    final userBooksRepository = FirebaseUserBooksRepository(
      FirebaseUserBooksDatasource(googleApiDataSource),
      googleApiDataSource,
    );

    final browseBloc = BrowseBloc(
      searchRepository,
      userBooksRepository,
    );

    browseBloc.add(FetchUserBooksRequested(
      context.read<LoginBloc>().state.user!.id!,
    ));

    return BlocProvider.value(
      value: browseBloc,
      child: AutoTabsScaffold(
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
      ),
    );
  }
}
