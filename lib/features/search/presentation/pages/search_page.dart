import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';
import 'package:lectura/features/search/presentation/widgets/book_result.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  void _onInputChanged() {
    final userId = context.read<LoginBloc>().state.user!.id!;
    context.read<BrowseBloc>().add(
          BrowseInputChanged(
            value: controller.text,
            userId: userId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    context.read<BrowseBloc>().add(FetchUserBooksRequested(
          context.read<LoginBloc>().state.user!.id!,
        ));
    return LecturaPage(
      title: context.l10n.search__page_title,
      padding: [20.0, 40.0, 20.0, 0.0].fromLTRB,
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              SearchBar(
                controller: controller,
                hintText: context.l10n.search__search_input__hint,
                trailing: controller.text.isNotEmpty
                    ? [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              controller.text = "";
                            });
                            _onInputChanged();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ]
                    : null,
                onChanged: (value) {
                  setState(() {
                    controller.text = value;
                  });
                  _onInputChanged();
                },
                elevation: const MaterialStatePropertyAll(1.0),
                shadowColor: const MaterialStatePropertyAll(Colors.transparent),
              ),
              25.0.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<BrowseBloc, BrowseState>(
                    builder: (context, state) {
                      if (state.status == BrowseStatus.searching) {
                        return const CircularProgressIndicator();
                      }

                      if (state.books.isEmpty) {
                        return Lottie.asset("assets/books.json", height: 125.0);
                      }

                      return Column(
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
                                        AutoRouter.of(context)
                                            .push(Routes.bookRoute);
                                      },
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
