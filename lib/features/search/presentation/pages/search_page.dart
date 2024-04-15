import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/features/search/data/repositories/search_repository.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SearchRepository>(
      create: (context) => SearchRepositoryImpl(GoogleApiDataSource()),
      child: LoginBlocConsumerWithLoading(
        builder: (context, state) => BlocProvider<BrowseBloc>(
          create: (context) => BrowseBloc(
            RepositoryProvider.of<SearchRepository>(context),
          ),
          child: LecturaPage(
            title: "***SEARCH",
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    TextField(
                      //controller: searchController,
                      onChanged: (value) {
                        context.read<BrowseBloc>().add(
                              BrowseInputChanged(value),
                            );
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...context.watch<BrowseBloc>().state.books.map(
                                  (e) => ListTile(
                                    title: Text(e.title ?? "..."),
                                  ),
                                )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            bottomNavigationBar: const AppBottomNavigationBar(
              currentPage: BottomBarCurrentPage.search,
            ),
          ),
        ),
      ),
    );
  }
}
