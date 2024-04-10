part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class LoginWithEmailAndPasswordRequested extends LoginEvent {
  const LoginWithEmailAndPasswordRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

final class LoginRetryAfterFailure extends LoginEvent {}

final class UserLoggedOut extends LoginEvent {}