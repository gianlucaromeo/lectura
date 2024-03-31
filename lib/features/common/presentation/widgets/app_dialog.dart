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

Future<dynamic> showAppFailureDialog({
  required BuildContext context,
  required Failure failure,
  Function? onClose,
}) async {
  final l10n = context.l10n;

  var title = l10n.generic_failure__title;
  var content = l10n.generic_failure__info;

  switch (failure.runtimeType) {
    case FirebaseAuthEmailAlreadyInUseFailure _:
      title = l10n.firebase_auth__failure__email_already_in_use__title;
      content = l10n.firebase_auth__failure__email_already_in_use__info;
      break;
    case FirebaseAuthInvalidEmailFailure _:
      title = l10n.firebase_auth__failure__invalid_email_title;
      content = l10n.firebase_auth__failure__invalid_email_info;
      break;
    case FirebaseAuthOperationNotAllowedFailure _:
      title = l10n.firebase_auth__failure__operation_not_allowed__title;
      content = l10n.firebase_auth__failure__operation_not_allowed__info;
      break;
    case FirebaseAuthWeakPasswordFailure _:
      title = l10n.firebase_auth__failure__weak_password__title;
      content = l10n.firebase_auth__failure__weak_password__info;
      break;
    case FirebaseAuthChannelErrorFailure _:
      title = l10n.firebase_auth__failure__auth_channel__title;
      content = l10n.firebase_auth__failure__auth_channel__info;
      break;
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
