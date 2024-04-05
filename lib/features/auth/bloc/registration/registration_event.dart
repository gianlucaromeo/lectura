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