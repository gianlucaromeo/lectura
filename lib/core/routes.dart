import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/router/app_router.dart';

class Routes {
  static get authRoute => const AuthRoute();
  static get homeRoute => const HomeRoute();
  static get profileRoute => const ProfileRoute();
  static get searchRoute => const SearchRoute();
  static get libraryRoute => const LibraryRoute();
  static BookRoute bookRoute(Book book) => BookRoute(book: book);
}