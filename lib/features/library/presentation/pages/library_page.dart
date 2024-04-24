import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/library/presentation/widgets/user_book.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BrowseBloc>().add(FetchUserBooksRequested(
      context.read<LoginBloc>().state.user!.id!,
    ));

    return LecturaPage(
      title: "***LIBRARY",
      body: Padding(
        padding: [20.0, 20.0, 20.0, 0.0].fromLTRB,
        child: Column(
          children: [
            /// BOOKS
            BlocBuilder<BrowseBloc, BrowseState>(
              builder: (context, state) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.userBooks
                            .map((e) => UserBook(book: e, onTap: () {})),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
