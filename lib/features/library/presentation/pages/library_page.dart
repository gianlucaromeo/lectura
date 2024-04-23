import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/login_bloc_consumer_with_loading.dart';

@RoutePage()
class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Set<BookStatus> selectedSegments = {BookStatus.currentlyReading};

  @override
  Widget build(BuildContext context) {
    return LoginBlocConsumerWithLoading(
      builder: (context, state) => LecturaPage(
        title: "***LIBRARY",
        body: Padding(
          padding: [20.0, 20.0, 20.0, 0.0].fromLTRB,
          child: Column(
            children: [
              SegmentedButton(
                multiSelectionEnabled: true,
                segments: [
                  ButtonSegment(
                    value: BookStatus.read,
                    label: Text(context.l10n.book_status__read),
                  ),
                  ButtonSegment(
                    value: BookStatus.currentlyReading,
                    label: Text(context.l10n.book_status__currently_reading),
                  ),
                  ButtonSegment(
                    value: BookStatus.toRead,
                    label: Text(context.l10n.book_status__to_read),
                  ),
                ],
                style: SegmentedButton.styleFrom(
                  padding: 6.0.horizontal, // TODO
                ),
                selected: selectedSegments,
                onSelectionChanged: (newSelection) {
                  setState(() {
                    selectedSegments = newSelection;
                  });
                },
                showSelectedIcon: false,
              ),
              25.0.verticalSpace,

              /// BOOKS
              
            ],
          ),
        ),
      ),
    );
  }
}
