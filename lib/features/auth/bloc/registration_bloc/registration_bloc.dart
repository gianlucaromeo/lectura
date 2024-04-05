import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/use_cases/create_user_with_email_and_password.dart';

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

/// STATE
enum RegistrationStatus { unknown, loading, failed, registered }

class RegistrationState extends Equatable {
  const RegistrationState._({
    this.status = RegistrationStatus.unknown,
  });

  const RegistrationState.unknown()
      : this._(status: RegistrationStatus.unknown);

  const RegistrationState.loading()
      : this._(status: RegistrationStatus.loading);

  const RegistrationState.failed() : this._(status: RegistrationStatus.failed);

  const RegistrationState.registered()
      : this._(status: RegistrationStatus.registered);

  final RegistrationStatus status;

  @override
  List<Object?> get props => [
        status,
      ];
}

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
  ) {
    CreateUserWithEmailAndPassword(_authRepository).call(
      EmailAndPasswordAuthParams(
        email: event.email,
        password: event.password,
      ),
    );
  }

  ///
  final AuthRepository _authRepository;
}
