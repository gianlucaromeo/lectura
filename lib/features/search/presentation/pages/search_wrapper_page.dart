import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/common/data/datasources/user_books_datasource.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/features/search/data/repositories/search_repository.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class SearchWrapperPage extends StatelessWidget {
  const SearchWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SearchRepository>(
      create: (context) => SearchRepositoryImpl(
        GoogleApiDataSource(),
        context.read<UserBooksDatasource>(),
      ),
      child: LoginBlocConsumerWithLoading(
        builder: (context, state) => BlocProvider<BrowseBloc>(
          create: (context) => BrowseBloc(
            RepositoryProvider.of<SearchRepository>(context),
          ),
          child: const AutoRouter(),
        ),
      ),
    );
  }
}
