import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:lectura/core/app_validator.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/use_case.dart';

class AppEmailValidator extends AppValidator<NoParams> {
  AppEmailValidator(super.params, super.context);

  @override
  String? internalValidate(String? value, NoParams params) {
    value = value?.trim();
    if (value?.isNotEmpty == true) {
      return EmailValidator.validate(value!)
          ? null
          : context.l10n.auth__common__errors__invalid_email;
    }
    return context.l10n.auth__common__errors__email_empty;
  }
}

class AppPasswordValidator extends AppValidator<NoParams> {
  AppPasswordValidator(super.params, super.context);

  @override
  String? internalValidate(String? value, NoParams params) {
    if (value?.isEmpty == true) {
      return super.context.l10n.auth__common__errors__password_empty;
    }

    //
    // ?= means "Positive Lookahead": checks pattern without consuming any characters.
    //
    // (?=.*[A-Z]): Positive Lookahead - at least one capital letter
    // (?=.*[a-z]): Positive Lookahead - at least one lower-case letter
    // (?=.*[0-9]): Positive Lookahead - at least one number
    // (?=.*[!@#\$&*~]): Positive Lookahead - at least one special character
    // {8,}: Match any character (.) at least 8 times
    //
    // const pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[?!@#\$&*~]).{8,}$';

    const capitalLetterPattern = r'(?=.*[A-Z])';
    const lowerCaseLetter = r'(?=.*[a-z])';
    const numbersPattern = r'(?=.*[0-9])';
    const specialCharactersPattern = r'(?=.*[?!@#\$&*~])';

    List<String> errors = [];

    if (!RegExp(capitalLetterPattern).hasMatch(value!)) {
      errors.add(context.l10n.auth__signup_form__err__capital_letter);
    }

    if (!RegExp(lowerCaseLetter).hasMatch(value)) {
      errors.add(context.l10n.auth__signup_form__err__lower_case_letter);
    }

    if (!RegExp(numbersPattern).hasMatch(value)) {
      errors.add(context.l10n.auth__signup_form__err__numbers);
    }

    if (!RegExp(specialCharactersPattern).hasMatch(value)) {
      errors.add(context.l10n.auth__signup_form__err__special_chars);
    }

    const min = 8;
    const max = 50;
    if (value.length < min || value.length > (max - 1)) {
      errors.add(context.l10n.auth__signup_form__err__chars_length(min, max));
    }

    return errors.isEmpty ? null : errors.join("\n");
  }
}

class AppConfirmPasswordValidatorParams {
  AppConfirmPasswordValidatorParams({
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
}

class AppConfirmPasswordValidator
    extends AppValidator<AppConfirmPasswordValidatorParams> {
  AppConfirmPasswordValidator(super.params, super.context);

  @override
  String? internalValidate(
      String? value, AppConfirmPasswordValidatorParams params) {
    final password = params.passwordController.text;
    final confirmPassword = params.confirmPasswordController.text;

    if (password.isEmpty) {
      return context.l10n.auth__signup_form__err__password_empty;
    } else if (confirmPassword.isEmpty) {
      return context.l10n.auth__signup_form__err__confirm_password_empty;
    } else if (password != confirmPassword) {
      return context.l10n.auth__signup_form__err__passwords_not_matching;
    }

    return null;
  }
}
