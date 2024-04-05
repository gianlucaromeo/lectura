import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/auth/bloc/registration/registration_event.dart';
import 'package:lectura/features/auth/bloc/registration/registration_state.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/use_cases/create_user_with_email_and_password.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegistrationState.unknown()) {
    /// Registration Requested
    on<RegistrationRequested>(_onRegistrationRequested);
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

    if (resp.isLeft()) {
      emit(const RegistrationState.failed());
    } else {
      emit(const RegistrationState.registered());
    }
  }

  final AuthRepository _authRepository;
}
