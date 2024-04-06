part of 'registration_bloc.dart';

enum RegistrationStatus { unknown, inProgress, failed, registered, retryAfterFailure }

class RegistrationState extends Equatable {
  const RegistrationState._({
    this.status = RegistrationStatus.unknown,
    this.registrationFailure,
  });

  const RegistrationState.unknown()
      : this._(status: RegistrationStatus.unknown);

  const RegistrationState.inProgress()
      : this._(status: RegistrationStatus.inProgress);

  const RegistrationState.failed(Failure failure)
      : this._(
          status: RegistrationStatus.failed,
          registrationFailure: failure,
        );

  const RegistrationState.registered()
      : this._(status: RegistrationStatus.registered);

  const RegistrationState.retryAfterFailure() : this._(status: RegistrationStatus.retryAfterFailure);

  final RegistrationStatus status;
  final Failure? registrationFailure;

  @override
  List<Object?> get props => [
        status,
      ];
}
