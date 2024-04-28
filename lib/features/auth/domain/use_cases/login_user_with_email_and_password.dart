import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/domain/entities/user.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';

class EmailAndPasswordLoginParams {
  const EmailAndPasswordLoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class LoginUserWithEmailAndPassword extends UseCase<User, EmailAndPasswordLoginParams> {
  final AuthRepository authRepository;

  LoginUserWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, User>> call(EmailAndPasswordLoginParams params) async {
    return authRepository.loginUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}
