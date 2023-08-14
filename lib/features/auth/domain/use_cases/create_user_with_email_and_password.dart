import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';

class EmailAndPasswordAuthParams {
  const EmailAndPasswordAuthParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class CreateUserWithEmailAndPassword extends UseCase<bool, EmailAndPasswordAuthParams> {
  final AuthRepository authRepository;

  CreateUserWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(EmailAndPasswordAuthParams params) async {
    return await authRepository.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}
