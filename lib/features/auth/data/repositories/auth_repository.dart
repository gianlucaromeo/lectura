import 'package:dartz/dartz.dart';
import 'package:lectura/core/exceptions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/network_info.dart';
import 'package:lectura/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lectura/features/auth/domain/entities/user.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await authRemoteDataSource.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        );
      } catch (e) {
        if (e is ServerException) {
          return Left(e.failure);
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await authRemoteDataSource
              .loginUserWithEmailAndPassword(
                email: email,
                password: password,
              )
              .then((dto) => dto.toEntity()),
        );
      } catch (e) {
        if (e is ServerException) {
          return Left(e.failure);
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await authRemoteDataSource
              .loginWithGoogle()
              .then((dto) => dto.toEntity()),
        );
      } catch (e) {
        if (e is ServerException) {
          return Left(e.failure);
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Future<void>>> logout() async {
    return Right(authRemoteDataSource.logout());
  }

  @override
  Future<Either<Failure, Future<void>>> deleteUser() async {
    return Right(authRemoteDataSource.deleteUser());
  }

  @override
  Stream<User> get user {
    return authRemoteDataSource.user.map((dto) => dto.toEntity());
  }
}
