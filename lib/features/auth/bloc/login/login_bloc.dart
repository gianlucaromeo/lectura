import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/domain/entities/user.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/use_cases/login_user_with_email_and_password.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState.unknown()) {
    on<LoginWithEmailAndPasswordRequested>(
      _onLoginWithEmailAndPasswordRequested,
    );

    on<LoginRetryAfterFailure>(_onLoginRetryAfterFailure);
    on<UserLoggedOut>(_onUserLoggedOut);
  }

  final AuthRepository _authRepository;

  void _onLoginWithEmailAndPasswordRequested(
    LoginWithEmailAndPasswordRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.inProgress());

    final resp = await LoginUserWithEmailAndPassword(_authRepository).call(
      EmailAndPasswordLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    if (resp.isFailure) {
      emit(LoginState.failed(resp.failure));
    } else {
      emit(LoginState.loggedIn(resp.user));
    }
  }

  void _onLoginRetryAfterFailure(
    LoginRetryAfterFailure event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.retryAfterFailure());
  }

  void _onUserLoggedOut(
    UserLoggedOut event,
    Emitter<LoginState> emit,
  ) {
    emit(const LoginState.unknown());
  }
}
