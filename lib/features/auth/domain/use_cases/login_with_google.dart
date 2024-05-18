import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/domain/entities/user.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';

class LoginWithGoogle extends UseCase<User, NoParams> {
  const LoginWithGoogle(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
   return authRepository.loginWithGoogle();
  }
}