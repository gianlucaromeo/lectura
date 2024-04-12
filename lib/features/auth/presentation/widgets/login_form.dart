import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/keys.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/auth/data/failures/firebase_auth_failures.dart';
import 'package:lectura/features/auth/presentation/validators/auth_validators.dart';
import 'package:lectura/core/utils.dart';
import 'package:lectura/features/auth/presentation/widgets/google_login_button.dart';
import 'package:lectura/features/common/presentation/widgets/app_dialog.dart';
import 'package:lectura/features/common/presentation/widgets/app_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginForm> {
  final emailHandler = FormFieldHandler(
    textEditingController: TextEditingController(text: "gianlucaromeo@outlook.com"), // TODO Remove
  );
  final passwordHandler = FormFieldHandler(
    textEditingController: TextEditingController(text: "Password1?"), // TODO Remove
  );

  final _formKey = FormKey();

  bool isFormUnvalid = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // Close the loading dialog when not loading anymore
        if (isLoading && state.status != LoginStatus.inProgress) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).maybePop();
        }

        switch (state.status) {
          case LoginStatus.retryAfterFailure:
            Navigator.of(context).maybePop();
            break;
          case LoginStatus.unknown:
            break;
          case LoginStatus.inProgress:
            setState(() {
              isLoading = true;
            });
            showAppLoadingDialog(context);
            break;
          case LoginStatus.failed:
            _handleFailure(state.loginFailure ?? GenericFailure());
            break;
          case LoginStatus.loggedIn:
            AutoRouter.of(context).replace(Routes.homeRoute);
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
              context.l10n.auth__login_form__title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            24.0.verticalSpace,

            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// EMAIL
                  AppTextFormField(
                    key: const Key(AppKeys.loginEmailField),
                    handler: emailHandler,
                    isFormUnvalid: isFormUnvalid,
                    appValidator: AppEmailValidator(NoParams(), context),
                    hintText: context.l10n.auth__login_form__email__hint,
                    label: context.l10n.auth__login_form__email__label,
                    keyboardType: TextInputType.emailAddress,
                    onSubmittedSuccess: () {
                      FocusScope.of(context)
                          .requestFocus(passwordHandler.focusNode);
                    },
                  ),
                  24.0.verticalSpace,

                  /// PASSWORD
                  AppTextFormField(
                    key: const Key(AppKeys.loginPasswordField),
                    handler: passwordHandler,
                    isFormUnvalid: isFormUnvalid,
                    appValidator: AppPasswordValidator(NoParams(), context),
                    showAndHidePasswordMode: true,
                    label: context.l10n.auth__login_form__password__label,
                    keyboardType: TextInputType.visiblePassword,
                    onSubmittedSuccess: _handleLogin,
                  ),
                  24.0.verticalSpace,

                  /// LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      key: const Key(AppKeys.loginButton),
                      onPressed: _handleLogin,
                      child: Text(context.l10n.auth__login_form__login__btn),
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

  void _handleLogin() {
    FocusScope.of(context).unfocus(); // Hide keyboard

    if (_formKey.currentState!.validate()) {
      final email = emailHandler.controller.text;
      final password = passwordHandler.controller.text;

      context.read<LoginBloc>().add(
            LoginWithEmailAndPasswordRequested(
              email: email,
              password: password,
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

    if (failure is FirebaseAuthInvalidEmailFailure) {
      onClose = () {
        emailHandler.focusNode.requestFocus();
      };
    } else if (failure is FirebaseWrongPasswordFailure) {
      onClose = () {
        passwordHandler.focusNode.requestFocus();
      };
    } else if (failure is GenericFailure) {
      onClose = () {
        Focus.of(context).unfocus();
      };
    }

    showAppFailureDialog(
        context: context,
        failure: failure,
        onClose: () {
          context.read<LoginBloc>().add(LoginRetryAfterFailure());
          onClose?.call();
        });
  }
}
