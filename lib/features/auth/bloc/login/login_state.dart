part of 'login_bloc.dart';

enum LoginStatus { unknown, inProgress, failed, loggedIn, retryAfterFailure }

class LoginState extends Equatable {
  const LoginState._({
    this.user,
    this.status = LoginStatus.unknown,
    this.loginFailure,
  });

  const LoginState.unknown() : this._();

  const LoginState.inProgress(User? user)
      : this._(
          user: user,
          status: LoginStatus.inProgress,
        );

  const LoginState.failed(Failure failure)
      : this._(
          status: LoginStatus.failed,
          loginFailure: failure,
        );

  const LoginState.loggedIn(User user)
      : this._(
          user: user,
          status: LoginStatus.loggedIn,
        );

  const LoginState.retryAfterFailure()
      : this._(status: LoginStatus.retryAfterFailure);

  final LoginStatus status;
  final User? user;
  final Failure? loginFailure;

  @override
  List<Object?> get props => [
        user,
        status,
        loginFailure,
      ];
}
