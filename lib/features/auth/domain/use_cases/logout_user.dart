import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';

class LogoutUser extends UseCase<Future<void>, NoParams> {
  LogoutUser(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Future<void>>> call(NoParams params) {
    return authRepository.logout();
  }
}