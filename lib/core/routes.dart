import 'package:lectura/router/app_router.dart';

class Routes {
  static get authRoute => const AuthRoute();

  static get homeWrapperRoute => const HomeWrapperRoute();
  static get homeRoute => const HomeRoute();
  static get profileRoute => const ProfileRoute();

  static get browseBlocWrapperRoute => const BrowseBlocWrapperRoute();
  static get searchRoute => const SearchRoute();
  static get libraryRoute => const LibraryRoute();
  static get bookRoute => const BookRoute();
}