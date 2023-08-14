import 'package:flutter/cupertino.dart';

abstract class AppValidator<Params> {
  AppValidator(this.params, this.context);

  final BuildContext context; // For localizations
  final Params params;

  // Useful for TextFormField's validate property.
  String? validate(String? value) => internalValidate(value, params);

  /// Concrete implementation of the [validate()] method.
  String? internalValidate(String? value, Params params);
}