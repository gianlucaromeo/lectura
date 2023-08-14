import 'package:flutter/material.dart';
import 'package:lectura/core/utils.dart';
import 'package:lectura/core/app_validator.dart';

class AppTextFormField extends StatefulWidget {
  AppTextFormField({
    super.key,
    required this.handler,
    this.appValidator,
    this.label,
    this.hintText,
    this.obscureText,
    this.keyboardType,
    this.autovalidateMode,
    this.onSubmittedSuccess,
    this.onChanged,
    this.showAndHidePasswordMode = false,
    this.isFormUnvalid = false,
  }) {
    if (showAndHidePasswordMode) {
      assert(obscureText == null,
          "If [showAndHidePasswordMode] is true, [obscureText] must be null");
    }
  }

  /// If [true], this widget validates internally.
  ///
  /// <br> Since this widget's validation logic is based on whether the user
  /// already inserted a wrong input or not, it must be consider that this field
  /// is placed inside a [Form] widget, which has its own logics.
  final bool isFormUnvalid;

  final AppValidator? appValidator;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function? onSubmittedSuccess;
  final Function? onChanged;
  final AutovalidateMode? autovalidateMode;

  final FormFieldHandler handler;

  /// Must be [null] if the [showAndHidePasswordMode] field is [true].
  final bool? obscureText;

  /// If [true], this widget automatically handles the show/hide logic of a field,
  /// with a default icon.
  ///
  /// <br>If [true], the [obscureText] field must be [null].
  final bool showAndHidePasswordMode;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool hasBeenInvalidAtLeastOnce = false;
  bool internalObscureText = false;

  @override
  void didUpdateWidget(covariant AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFormUnvalid) {
      _onFormUnvalid();
    }
  }

  @override
  void initState() {
    super.initState();
    internalObscureText = widget.obscureText ?? widget.showAndHidePasswordMode;
    if (widget.isFormUnvalid) {
      _onFormUnvalid();
    }
  }

  /// Updates the UX logic, checking whether this field has been validated
  /// through the [Form] inside which is placed.
  void _onFormUnvalid() {
    if (!_validate()) {
      _updateHasBeenValidatedAtLeastOnce();
    }
  }

  bool _validate() =>
      widget.handler.formFieldKey.currentState?.validate() == true;

  void _updateHasBeenValidatedAtLeastOnce() {
    if (!hasBeenInvalidAtLeastOnce) {
      // (UX)
      // The user submitted for their first time an invalid input.
      setState(() {
        hasBeenInvalidAtLeastOnce = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.handler.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.handler.formFieldKey,
      controller: widget.handler.controller,
      focusNode: widget.handler.focusNode,
      validator: widget.appValidator?.validate,
      onChanged: (value) {
        // (UX)
        // Avoid showing the error while the user is typing for the first time,
        // as they might be inserting a correct input.
        if (hasBeenInvalidAtLeastOnce) {
          // (UX)
          // The user already submitted a wrong input.
          // Thus, now we will validate this field each time the user types,
          // so they can easily see what the error is.
          _validate();
        }
        widget.onChanged?.call();
      },
      onFieldSubmitted: (_) {
        if (!_validate()) {
          _updateHasBeenValidatedAtLeastOnce();
          widget.handler.focusNode
              .requestFocus(); // Keep the keyboard open when validate fails
        } else {
          widget.onSubmittedSuccess?.call();
        }
      },
      keyboardType: widget.keyboardType,
      autovalidateMode: widget.autovalidateMode,
      obscureText: widget.obscureText ?? internalObscureText,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        suffixIcon: widget.showAndHidePasswordMode == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    internalObscureText = !internalObscureText;
                  });
                },
                icon: Icon(
                  internalObscureText
                      ? Icons.remove_red_eye
                      : Icons.hide_source_outlined,
                ),
              )
            : null,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontWeight: FontWeight.normal,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        )),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        hintText: widget.hintText,
        label: widget.label?.isNotEmpty == true ? Text(widget.label!) : null,
      ),
    );
  }
}
