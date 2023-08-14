import 'package:flutter/material.dart';

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
