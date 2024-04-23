import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/router/app_router.dart';

class Routes {
  static get authRoute => const AuthRoute();
  static get homeRoute => const HomeRoute();
  static get searchWrapperRoute => const SearchWrapperRoute();
  static get profileRoute => const ProfileRoute();
  static get searchRoute => const SearchRoute();
  static get libraryRoute => LibraryRoute();
  static get bookRoute => const BookRoute();
}