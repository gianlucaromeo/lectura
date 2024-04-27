import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lectura/app.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/network_info.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lectura/features/auth/data/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/common/bloc/theme/theme_bloc.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';
import 'package:lectura/firebase_options.dart';
import 'package:lectura/core/app_env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lectura/features/common/data/datasources/user_books_datasource.dart';
import 'package:lectura/features/common/data/repositories/user_books_repository.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/features/search/data/repositories/search_repository.dart';

import 'features/search/presentation/bloc/browse_bloc.dart';

// Call this from one of the class of the "/main" folder
Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (kDebugMode) {
    prefs.logAll();
  }

  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: FirebaseAuthDataSource(),
    networkInfo: NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  final googleApiDataSource = GoogleApiDataSource();

  final searchRepository = SearchRepositoryImpl(
    googleApiDataSource,
  );

  final userBooksRepository = FirebaseUserBooksRepository(
    FirebaseUserBooksDatasource(googleApiDataSource),
    googleApiDataSource,
  );

  runApp(
    RepositoryProvider<AuthRepository>.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (context) => LoginBloc(authRepository: authRepository),
          ),
          BlocProvider(
            create: (context) => BrowseBloc(
              searchRepository,
              userBooksRepository,
            ),
          ),
        ],
        child: App(appEnvironment: environment),
      ),
    ),
  );
}
