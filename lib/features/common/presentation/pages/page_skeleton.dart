import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';

class LecturaPage extends StatelessWidget {
  const LecturaPage({
    super.key,
    required this.body,
    this.title,
    this.bottomNavigationBar,
    this.padding,
  });

  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title?.isNotEmpty == true ? Text(title!) : null,
        titleSpacing: 20.0,
        elevation: 1.0,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: padding ?? 20.0.all,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
