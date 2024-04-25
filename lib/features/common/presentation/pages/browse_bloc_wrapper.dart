import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/common/data/datasources/user_books_datasource.dart';
import 'package:lectura/features/common/data/repositories/user_books_repository.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/features/search/data/repositories/search_repository.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class BrowseBlocWrapperPage extends StatelessWidget {
  const BrowseBlocWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SearchRepository>(
          create: (context) => SearchRepositoryImpl(
            GoogleApiDataSource(),
          ),
        ),
        RepositoryProvider<UserBooksRepository>(
          create: (context) => FirebaseUserBooksRepository(
            FirebaseUserBooksDatasource(GoogleApiDataSource()),
            GoogleApiDataSource(),
          ),
        ),
      ],
      child: BlocProvider<BrowseBloc>(
        create: (context) => BrowseBloc(
          context.read<SearchRepository>(),
          context.read<UserBooksRepository>(),
        ),
        child: const AutoRouter(),
      ),
    );
  }
}