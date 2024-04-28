import 'package:auto_route/auto_route.dart';
import 'package:lectura/features/auth/presentation/pages/auth_page.dart';
import 'package:lectura/features/home/presentation/pages/home_page.dart';
import 'package:lectura/features/profile/presentation/pages/profile_page.dart';
import 'package:lectura/features/search/presentation/pages/search_page.dart';
import 'package:lectura/features/search/presentation/pages/book_page.dart';
import 'package:lectura/features/library/presentation/pages/library_page.dart';
import 'package:lectura/features/common/presentation/pages/search_wrapper_page.dart';
import 'package:lectura/features/common/presentation/pages/library_wrapper_page.dart';
import 'package:lectura/features/common/presentation/pages/logged_user_page.dart';
import 'package:lectura/features/common/presentation/pages/homepage_wrapper.dart';
import 'package:lectura/features/common/presentation/pages/login_wrapper_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
          page: LoginWrapperRoute.page,
          path: "/login-wrapper",
          initial: true,
          children: [
            /// AUTH
            AutoRoute(path: "auth", page: AuthRoute.page),

            /// LOGGED USER
            AutoRoute(
                page: LoggedUserRoute.page,
                path: "logged-user",
                initial: true,
                children: [
                  /// SEARCH
                  AutoRoute(
                      path: "search-wrapper",
                      page: SearchWrapperRoute.page,
                      children: [
                        AutoRoute(
                            path: "search",
                            page: SearchRoute.page,
                            initial: true,
                        ),
                        AutoRoute(path: "book", page: BookRoute.page),
                      ]),

                  /// LIBRARY
                  AutoRoute(
                      path: "library-wrapper",
                      page: LibraryWrapperRoute.page,
                      initial: true,
                      children: [
                        AutoRoute(
                            path: "library",
                            page: LibraryRoute.page,
                            initial: true,
                        ),
                        AutoRoute(path: "book", page: BookRoute.page),
                      ]),

                  /// PROFILE
                  AutoRoute(path: "profile", page: ProfileRoute.page),
                ]),
          ]),
    ];
  }
}
