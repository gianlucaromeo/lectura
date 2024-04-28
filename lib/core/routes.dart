import 'package:auto_route/auto_route.dart';
import 'package:lectura/router/app_router.dart';

class Routes {
  static PageRouteInfo get authRoute => const AuthRoute();

  static PageRouteInfo get homeWrapperRoute => const HomeWrapperRoute();
  static PageRouteInfo get homeRoute => const HomeRoute();
  static PageRouteInfo get profileRoute => const ProfileRoute();

  static PageRouteInfo get searchWrapperRoute => const SearchWrapperRoute();
  static PageRouteInfo get searchRoute => const SearchRoute();

  static PageRouteInfo get libraryWrapperRoute => const LibraryWrapperRoute();
  static PageRouteInfo get libraryRoute => const LibraryRoute();

  static PageRouteInfo get bookRoute => const BookRoute();
}