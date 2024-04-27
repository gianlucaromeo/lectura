import 'package:auto_route/auto_route.dart';
import 'package:lectura/features/auth/presentation/pages/auth_page.dart';
import 'package:lectura/features/home/presentation/pages/home_page.dart';
import 'package:lectura/features/profile/presentation/pages/profile_page.dart';
import 'package:lectura/features/search/presentation/pages/search_page.dart';
import 'package:lectura/features/search/presentation/pages/book_page.dart';
import 'package:lectura/features/library/presentation/pages/library_page.dart';
import 'package:lectura/features/common/presentation/pages/browse_bloc_wrapper.dart';
import 'package:lectura/features/common/presentation/pages/logged_user_page.dart';
import 'package:lectura/features/common/presentation/pages/homepage_wrapper.dart';
import 'package:lectura/features/common/presentation/pages/login_wrapper_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: LoginWrapperRoute.page, initial: true, children: [
        /// AUTH
        AutoRoute(page: AuthRoute.page),

        AutoRoute(page: LoggedUserRoute.page, initial: true, children: [
          /// HOME
          AutoRoute(page: HomeWrapperRoute.page, children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ]),

          /// SEARCH, LIBRARY
          AutoRoute(
              page: BrowseBlocWrapperRoute.page,
              initial: true,
              children: [
                AutoRoute(page: SearchRoute.page, initial: true,),
                AutoRoute(page: LibraryRoute.page, maintainState: true),
                AutoRoute(page: BookRoute.page),
              ]),
        ]),
      ]),
    ];
  }
}
