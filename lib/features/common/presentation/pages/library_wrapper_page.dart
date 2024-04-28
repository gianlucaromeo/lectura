import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LibraryWrapperPage extends StatelessWidget {
  const LibraryWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
