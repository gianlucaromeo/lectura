import 'package:lectura/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_providers.g.dart';

@Riverpod()
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return FirebaseAuthDataSource();
}
