import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/keys.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/bloc/registration/registration_bloc.dart';
import 'package:lectura/features/auth/data/failures/firebase_auth_failures.dart';
import 'package:lectura/features/auth/presentation/validators/auth_validators.dart';
import 'package:lectura/core/utils.dart';
import 'package:lectura/features/auth/presentation/widgets/google_login_button.dart';
import 'package:lectura/features/common/presentation/widgets/app_dialog.dart';
import 'package:lectura/features/common/presentation/widgets/app_text_form_field.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationForm> {
  final emailHandler = FormFieldHandler(
    textEditingController: TextEditingController(text: "gianlucaromeo@outlook.com"), // TODO Remove
  );
  final passwordHandler = FormFieldHandler(
    textEditingController: TextEditingController(text: "Password1?"), // TODO Remove
  );
  final confirmPasswordHandler = FormFieldHandler(
    textEditingController: TextEditingController(text: "Password1?"), // TODO Remove
  );

  final _formKey = FormKey();

  bool isFormUnvalid = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        // Close the loading dialog when not loading anymore
        if (isLoading && state.status != RegistrationStatus.inProgress) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).maybePop();
        }

        switch (state.status) {
          case RegistrationStatus.retryAfterFailure:
            Navigator.of(context).maybePop();
            break;
          case RegistrationStatus.unknown:
            break;
          case RegistrationStatus.inProgress:
            setState(() {
              isLoading = true;
            });
            showAppLoadingDialog(context);
            break;
          case RegistrationStatus.failed:
            _handleFailure(state.registrationFailure ?? GenericFailure());
            break;
          case RegistrationStatus.registered:
            showAppGenericDialog(
              context: context,
              title: context.l10n.auth__signup_form__registration_success__dialog__title,
              content: context.l10n.auth__signup_form__registration_success__dialog__content,
              onClose: () {
                AutoRouter.of(context).maybePop();
                setState(() {
                  isLoading = false;
                });
              },
            );
            break;
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            48.0.verticalSpace,

            /// TITLE
            Text(
              context.l10n.auth__signup_form__title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            6.0.verticalSpace,

            /// SUBTITLE
            Text(
              context.l10n.auth__signup_form__subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            24.0.verticalSpace,

            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// EMAIL
                  AppTextFormField(
                    key: const Key(AppKeys.registrationEmailField),
                    handler: emailHandler,
                    isFormUnvalid: isFormUnvalid,
                    appValidator: AppEmailValidator(NoParams(), context),
                    hintText: context.l10n.auth__signup_form__email__hint,
                    label: context.l10n.auth__signup_form__email__label,
                    keyboardType: TextInputType.emailAddress,
                    onSubmittedSuccess: () {
                      FocusScope.of(context)
                          .requestFocus(passwordHandler.focusNode);
                    },
                  ),
                  24.0.verticalSpace,

                  /// PASSWORD
                  AppTextFormField(
                    key: const Key(AppKeys.registrationPasswordField),
                    handler: passwordHandler,
                    isFormUnvalid: isFormUnvalid,
                    appValidator: AppPasswordValidator(NoParams(), context),
                    showAndHidePasswordMode: true,
                    label: context.l10n.auth__signup_form__password__label,
                    keyboardType: TextInputType.visiblePassword,
                    onSubmittedSuccess: () {
                      FocusScope.of(context)
                          .requestFocus(confirmPasswordHandler.focusNode);
                    },
                  ),
                  24.0.verticalSpace,

                  /// CONFIRM PASSWORD
                  AppTextFormField(
                    key: const Key(AppKeys.registrationConfirmPasswordField),
                    isFormUnvalid: isFormUnvalid,
                    appValidator: AppConfirmPasswordValidator(
                      AppConfirmPasswordValidatorParams(
                        passwordController: passwordHandler.controller,
                        confirmPasswordController:
                            confirmPasswordHandler.controller,
                      ),
                      context,
                    ),
                    handler: confirmPasswordHandler,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    label:
                        context.l10n.auth__signup_form__confirm_password__label,
                    keyboardType: TextInputType.visiblePassword,
                    showAndHidePasswordMode: true,
                    onSubmittedSuccess: _handleRegistration,
                  ),
                  24.0.verticalSpace,

                  /// REGISTER BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      key: const Key(AppKeys.registerButton),
                      onPressed: _handleRegistration,
                      child:
                          Text(context.l10n.auth__signup_form__register__btn),
                    ),
                  ),
                  24.0.verticalSpace,

                  const Divider(
                    height: 0.0,
                  ),
                  24.0.verticalSpace,

                  /// GOOGLE LOGIN BUTTON
                  const GoogleLoginButton(),
                  48.0.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegistration() {
    FocusScope.of(context).unfocus(); // Hide keyboard

    if (_formKey.currentState!.validate()) {
      final email = emailHandler.controller.text;
      final password = passwordHandler.controller.text;
      final passwordConfirmation = confirmPasswordHandler.controller.text;

      context.read<RegistrationBloc>().add(
            RegistrationRequested(
              email: email,
              password: password,
              passwordConfirmation: passwordConfirmation,
            ),
          );
    } else {
      setState(() {
        isFormUnvalid = true;
      });
    }
  }

  void _handleFailure(Failure failure) {
    Function? onClose;

    if (failure is FirebaseAuthInvalidEmailFailure ||
        failure is FirebaseAuthEmailAlreadyInUseFailure) {
      onClose = () {
        emailHandler.focusNode.requestFocus();
      };
    } else if (failure is FirebaseAuthWeakPasswordFailure) {
      onClose = () {
        passwordHandler.focusNode.requestFocus();
      };
    }

    showAppFailureDialog(
        context: context,
        failure: failure,
        onClose: () {
          context.read<RegistrationBloc>().add(RegistrationRetryAfterFailure());
          onClose?.call();
        });
  }
}
