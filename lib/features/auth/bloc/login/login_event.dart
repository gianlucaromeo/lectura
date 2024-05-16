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

final class UserDeleteAccountRequested extends LoginEvent {
  const UserDeleteAccountRequested({required this.userId});
  final String userId;
}

final class _UserChanged extends LoginEvent {
  _UserChanged(this.user);
  final User user;
}