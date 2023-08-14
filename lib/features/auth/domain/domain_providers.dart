import 'package:lectura/core/network_info.dart';
import 'package:lectura/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lectura/features/auth/data/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'domain_providers.g.dart';

@Riverpod()
AuthRepository authRepository(
    AuthRepositoryRef ref,
    AuthRemoteDataSource authRemoteDataSource,
    NetworkInfo networkInfo,
    ) {
  return AuthRepositoryImpl(
    authRemoteDataSource: authRemoteDataSource,
    networkInfo: networkInfo,
  );
}