import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/features/auth/presentation/pages/auth_page.dart';
import 'package:lectura/features/home/presentation/pages/home_page.dart';
import 'package:lectura/features/profile/presentation/pages/profile_page.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/features/search/presentation/pages/search_page.dart';
import 'package:lectura/features/search/presentation/pages/book_page.dart';
import 'package:lectura/features/library/presentation/pages/library_page.dart';
import 'package:lectura/features/search/presentation/pages/search_wrapper_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SearchWrapperRoute.page, children: [
          AutoRoute(page: SearchRoute.page, initial: true),
          AutoRoute(page: BookRoute.page),
        ]),
        AutoRoute(page: LibraryRoute.page),
      ];
}
