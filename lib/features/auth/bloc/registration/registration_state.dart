import 'package:equatable/equatable.dart';

enum RegistrationStatus { unknown, inProgress, failed, registered }

extension RegistrationStatusIs on RegistrationStatus {
  bool get isOnProgress => this == RegistrationStatus.inProgress;
}

class RegistrationState extends Equatable {
  const RegistrationState._({
    this.status = RegistrationStatus.unknown,
  });

  const RegistrationState.unknown()
      : this._(status: RegistrationStatus.unknown);

  const RegistrationState.inProgress()
      : this._(status: RegistrationStatus.inProgress);

  const RegistrationState.failed() : this._(status: RegistrationStatus.failed);

  const RegistrationState.registered()
      : this._(status: RegistrationStatus.registered);

  final RegistrationStatus status;

  @override
  List<Object?> get props => [
    status,
  ];
}