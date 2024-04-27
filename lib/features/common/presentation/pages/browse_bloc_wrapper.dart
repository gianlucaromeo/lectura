import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class BrowseBlocWrapperPage extends StatelessWidget {
  const BrowseBlocWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {


    return BlocProvider(create: (context) => context.read<BrowseBloc>(), child: const AutoRouter());
  }
}
