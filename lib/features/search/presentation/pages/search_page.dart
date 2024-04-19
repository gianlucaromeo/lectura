import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';
import 'package:lectura/features/search/presentation/widgets/book_result.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  //final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LecturaPage(
      title: context.l10n.search__page_title,
      padding: [20.0, 20.0, 20.0, 0.0].fromLTRB,
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              SearchBar(
                hintText: context.l10n.search__search_input__hint,
                onChanged: (value) {
                  context.read<BrowseBloc>().add(
                    BrowseInputChanged(value),
                  );
                },
                elevation: const MaterialStatePropertyAll(1.0),
                shadowColor: const MaterialStatePropertyAll(Colors.transparent),
              ),
              25.0.verticalSpace,

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...context.watch<BrowseBloc>().state.books.map(
                            (book) => Column(
                              children: [
                                BookResult(
                                  book: book,
                                  onTap: () {
                                    context
                                        .read<BrowseBloc>()
                                        .add(OpenBookRequested(book));
                                    AutoRouter.of(context).push(Routes.bookRoute);
                                  },
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
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
    );
  }
}
