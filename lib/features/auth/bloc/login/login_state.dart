part of 'login_bloc.dart';

enum LoginStatus { unknown, inProgress, failed, loggedIn, retryAfterFailure }

class LoginState extends Equatable {
  const LoginState._({
    this.status = LoginStatus.unknown,
    this.loginFailure,
  });

  const LoginState.unknown() : this._(status: LoginStatus.unknown);

  const LoginState.inProgress() : this._(status: LoginStatus.inProgress);

  const LoginState.failed(Failure failure)
      : this._(
          status: LoginStatus.failed,
          loginFailure: failure,
        );

  const LoginState.loggedIn() : this._(status: LoginStatus.loggedIn);

  const LoginState.retryAfterFailure()
      : this._(status: LoginStatus.retryAfterFailure);

  final LoginStatus status;
  final Failure? loginFailure;

  @override
  List<Object?> get props => [
        status,
        loginFailure,
      ];
}
