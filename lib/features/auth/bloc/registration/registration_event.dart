part of 'registration_bloc.dart';

/// EVENTS
sealed class RegistrationEvent {
  const RegistrationEvent();
}

final class RegistrationRequested extends RegistrationEvent {
  const RegistrationRequested({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  final String email;
  final String password;
  final String passwordConfirmation;
}

final class RegistrationRetryAfterFailure extends RegistrationEvent {}