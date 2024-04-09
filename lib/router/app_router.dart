import 'package:auto_route/auto_route.dart';
import 'package:lectura/features/auth/presentation/pages/auth_page.dart';
import 'package:lectura/features/home/presentation/pages/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: "/auth", page: AuthRoute.page, initial: true),
    AutoRoute(path: "/home", page: HomeRoute.page),
  ];
}