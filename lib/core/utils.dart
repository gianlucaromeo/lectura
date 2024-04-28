import 'package:flutter/material.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';

typedef FormKey = GlobalKey<FormState>;
typedef FormFieldKey = GlobalKey<FormFieldState>;

class FormFieldHandler {
  FormFieldHandler({
    FormFieldKey? formFieldKey,
    TextEditingController? textEditingController,
    FocusNode? focusNode,
  }) {
    this.formFieldKey = formFieldKey ?? FormFieldKey();
    controller = textEditingController ?? TextEditingController();
    this.focusNode = focusNode ?? FocusNode();
  }

  late final FormFieldKey formFieldKey;
  late final TextEditingController controller;
  late final FocusNode focusNode;
}


/// Returns the corresponding text of a status based on the localization file.
/// i.e.: BookStatus.currentlyReading --> (app_en.arb) "Reading"
String getStatusText(BuildContext context, BookStatus status) {
  switch (status) {
    case BookStatus.read:
      return context.l10n.book_status__read;
    case BookStatus.currentlyReading:
      return context.l10n.book_status__currently_reading;
    case BookStatus.toRead:
      return context.l10n.book_status__to_read;
    case BookStatus.unknown:
      return "";
  }
}