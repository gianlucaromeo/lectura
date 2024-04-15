import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/routes.dart';

enum BottomBarCurrentPage {
  home,
  search,
  library,
  //profile
}

final _routes = [
  Routes.homeRoute,
  Routes.searchRoute,
  Routes.libraryRoute,
  //Routes.profileRoute,
];

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentPage,
  });

  final BottomBarCurrentPage currentPage;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int index = 0;

  @override
  void initState() {
    index = widget.currentPage.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "***home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "***search"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "***library"),
        //BottomNavigationBarItem(icon: Icon(Icons.person), label: "***profile"),
      ],
      currentIndex: index,
      onTap: (value) {
        setState(() {
          index = value;
        });
        AutoRouter.of(context).replace(_routes[value]);
      },
    );
  }
}