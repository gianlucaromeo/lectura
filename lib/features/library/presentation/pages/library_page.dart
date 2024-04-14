import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';

@RoutePage()
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBlocConsumerWithLoading(
      builder: (context, state) => const LecturaPage(
        title: "***LIBRARY",
        body: Column(
          children: [
            Text("***Test")
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(
          currentPage: BottomBarCurrentPage.library,
        ),
      ),
    );
  }
}
