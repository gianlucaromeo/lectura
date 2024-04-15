import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/utils.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:lectura/features/common/presentation/widgets/app_text_form_field.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';
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
    return LoginBlocConsumerWithLoading(
      builder: (context, state) => BlocProvider<BrowseBloc>(
        create: (context) => BrowseBloc(),
        child: LecturaPage(
          title: "***SEARCH",
          body: Builder(
            builder: (context) {
              return Column(
                children: [
                  TextField(
                    //controller: searchController,
                    onChanged: (value) {
                      context.read<BrowseBloc>().add(BrowseInputChanged(value));
                    },
                  ),
                ],
              );
            }
          ),
          bottomNavigationBar: const AppBottomNavigationBar(
            currentPage: BottomBarCurrentPage.search,
          ),
        ),
      ),
    );
  }
}
