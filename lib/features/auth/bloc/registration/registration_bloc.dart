import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/use_cases/create_user_with_email_and_password.dart';
import 'package:equatable/equatable.dart';
import 'package:lectura/core/failures.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegistrationState.unknown()) {
    on<RegistrationRequested>(_onRegistrationRequested);
    on<RegistrationRetryAfterFailure>(_onRegistrationRetryAfterFailure);
  }

  void _onRegistrationRequested(
    RegistrationRequested event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(const RegistrationState.inProgress());

    final resp = await CreateUserWithEmailAndPassword(_authRepository).call(
      EmailAndPasswordAuthParams(
        email: event.email,
        password: event.password,
      ),
    );

    if (resp.isFailure) {
      emit(RegistrationState.failed(resp.failure));
    } else {
      emit(const RegistrationState.registered());
    }
  }

  void _onRegistrationRetryAfterFailure(
    RegistrationRetryAfterFailure event,
    Emitter<RegistrationState> emit,
  ) {
    emit(const RegistrationState.retryAfterFailure());
  }

  final AuthRepository _authRepository;
}
