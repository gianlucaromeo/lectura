import 'package:lectura/features/auth/data/data_providers.dart';
import 'package:lectura/features/auth/data/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/providers/network_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'domain_providers.g.dart';

@Riverpod()
AuthRepository authRepository(AuthRepositoryRef ref) {
  final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
  final networkInfo = ref.read(networkInfoProvider);
  return AuthRepositoryImpl(
    authRemoteDataSource: authRemoteDataSource,
    networkInfo: networkInfo,
  );
}