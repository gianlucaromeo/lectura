import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/domain/entities/user.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/use_cases/delete_user.dart';
import 'package:lectura/features/auth/domain/use_cases/login_user_with_email_and_password.dart';
import 'package:lectura/features/auth/domain/use_cases/logout_user.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
    required UserBooksRepository userBooksRepository,
  })  : _authRepository = authRepository,
        _userBooksRepository = userBooksRepository,
        super(const LoginState.unknown()) {
    on<_UserChanged>(_onUserChanged);
    _userSubscription = _authRepository.user.listen((user) {
      add(_UserChanged(user));
    });

    on<LoginWithEmailAndPasswordRequested>(
      _onLoginWithEmailAndPasswordRequested,
    );

    on<LoginRetryAfterFailure>(_onLoginRetryAfterFailure);
    on<UserLoggedOut>(_onUserLoggedOut);
    on<UserDeleteAccountRequested>(_onUserDeleteAccountRequested);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  final AuthRepository _authRepository;
  final UserBooksRepository _userBooksRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onLoginWithEmailAndPasswordRequested(
    LoginWithEmailAndPasswordRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.inProgress(state.user));

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

  void _onUserChanged(
    _UserChanged event,
    Emitter<LoginState> emit,
  ) async {
    if (event.user.id?.isNotEmpty == true) {
      log("USER CHANGED: ${event.user.id}");
      emit(LoginState.loggedIn(event.user));
    } else {
      emit(const LoginState.unknown());
    }
  }

  void _onUserLoggedOut(
    UserLoggedOut event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.inProgress(state.user));
    await LogoutUser(_authRepository).call(NoParams());
    emit(const LoginState.unknown());
  }

  void _onUserDeleteAccountRequested(
    UserDeleteAccountRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.inProgress(state.user));
    await DeleteUser(_authRepository, _userBooksRepository)
        .call(DeleteUserParams(event.userId));
    emit(const LoginState.unknown());
  }
}
