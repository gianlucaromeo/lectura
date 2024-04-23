// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    BookRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BookPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LibraryRoute.name: (routeData) {
      final args = routeData.argsAs<LibraryRouteArgs>(
          orElse: () => const LibraryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LibraryPage(key: args.key),
      );
    },
    LoggedUserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoggedUserPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    SearchWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchWrapperPage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BookPage]
class BookRoute extends PageRouteInfo<void> {
  const BookRoute({List<PageRouteInfo>? children})
      : super(
          BookRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LibraryPage]
class LibraryRoute extends PageRouteInfo<LibraryRouteArgs> {
  LibraryRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LibraryRoute.name,
          args: LibraryRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LibraryRoute';

  static const PageInfo<LibraryRouteArgs> page =
      PageInfo<LibraryRouteArgs>(name);
}

class LibraryRouteArgs {
  const LibraryRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LibraryRouteArgs{key: $key}';
  }
}

/// generated route for
/// [LoggedUserPage]
class LoggedUserRoute extends PageRouteInfo<void> {
  const LoggedUserRoute({List<PageRouteInfo>? children})
      : super(
          LoggedUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoggedUserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchWrapperPage]
class SearchWrapperRoute extends PageRouteInfo<void> {
  const SearchWrapperRoute({List<PageRouteInfo>? children})
      : super(
          SearchWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
