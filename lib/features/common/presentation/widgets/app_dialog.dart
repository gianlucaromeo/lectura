import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/data/failures/firebase_auth_failures.dart';

Future showAppLoadingDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (_) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    },
  );
}

Future<dynamic> showAppGenericDialog({
  required BuildContext context,
  Function? onClose,
  required String title,
  required String content,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.error),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(thickness: 0.5),
            12.0.verticalSpace,
            Flexible(
              child: Text(
                content,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      );
    },
  );
  onClose?.call();
}

Future<dynamic> showAppFailureDialog({
  required BuildContext context,
  required Failure failure,
  Function? onClose,
}) async {
  final l10n = context.l10n;

  var title = l10n.generic_failure__title;
  var content = l10n.generic_failure__info;

  switch (failure.runtimeType) {
    case const (FirebaseAuthEmailAlreadyInUseFailure):
      title = l10n.firebase_auth__failure__email_already_in_use__title;
      content = l10n.firebase_auth__failure__email_already_in_use__info;
      break;
    case const (FirebaseAuthOperationNotAllowedFailure):
      title = l10n.firebase_auth__failure__operation_not_allowed__title;
      content = l10n.firebase_auth__failure__operation_not_allowed__info;
      break;
    case const (FirebaseAuthWeakPasswordFailure):
      title = l10n.firebase_auth__failure__weak_password__title;
      content = l10n.firebase_auth__failure__weak_password__info;
      break;
    case const (FirebaseAuthChannelErrorFailure):
      title = l10n.firebase_auth__failure__auth_channel__title;
      content = l10n.firebase_auth__failure__auth_channel__info;
      break;
    case const (FirebaseUserDisabledFailure):
      title = l10n.firebase_auth__failure__user_disabled__title;
      content = l10n.firebase_auth__failure__user_disabled__info;
      break;
    case const (FirebaseUserNotFoundFailure):
      title = l10n.firebase_auth__failure__user_not_found__title;
      content = l10n.firebase_auth__failure__user_not_found__info;
      break;
    case const (FirebaseWrongPasswordFailure):
      title = l10n.firebase_auth__failure__wrong_password__title;
      content = l10n.firebase_auth__failure__wrong_password__info;
      break;
    case const (FirebaseAuthInvalidEmailFailure):
      title = l10n.firebase_auth__failure__invalid_email__title;
      content = l10n.firebase_auth__failure__invalid_email__info;
      break;
    case const (FirebaseEmailNotVerifiedFailure):
      title = l10n.firebase_auth__failure__email_not_verified__title;
      content = l10n.firebase_auth__failure__email_not_verified__info;
    default:
      break;
  }

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.error),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(thickness: 0.5),
            12.0.verticalSpace,
            Flexible(
              child: Text(
                content,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      );
    },
  );
  onClose?.call();
}

Future<dynamic> showAppConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmationOption,
  required String denyOption,
  required Function? onConfirm,
  required Function? onDeny,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.warning_amber_outlined),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(thickness: 0.5),
            12.0.verticalSpace,
            Flexible(
              child: Text(
                content,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowButtonSpacing: 15.0, // padding between
        actions: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                onConfirm?.call();
                context.router.maybePop();
              },
              child: Text(confirmationOption),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                onDeny?.call();
                context.router.maybePop();
              },
              child: Text(denyOption),
            ),
          ),
        ],
      );
    },
  );
}
