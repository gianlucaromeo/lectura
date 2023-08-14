// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'df153ba85a333cff346cfb6d07da36295a85a751';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;

/// See also [authRepository].
@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryFamily();

/// See also [authRepository].
class AuthRepositoryFamily extends Family<AuthRepository> {
  /// See also [authRepository].
  const AuthRepositoryFamily();

  /// See also [authRepository].
  AuthRepositoryProvider call(
    AuthRemoteDataSource authRemoteDataSource,
    NetworkInfo networkInfo,
  ) {
    return AuthRepositoryProvider(
      authRemoteDataSource,
      networkInfo,
    );
  }

  @override
  AuthRepositoryProvider getProviderOverride(
    covariant AuthRepositoryProvider provider,
  ) {
    return call(
      provider.authRemoteDataSource,
      provider.networkInfo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authRepositoryProvider';
}

/// See also [authRepository].
class AuthRepositoryProvider extends AutoDisposeProvider<AuthRepository> {
  /// See also [authRepository].
  AuthRepositoryProvider(
    this.authRemoteDataSource,
    this.networkInfo,
  ) : super.internal(
          (ref) => authRepository(
            ref,
            authRemoteDataSource,
            networkInfo,
          ),
          from: authRepositoryProvider,
          name: r'authRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authRepositoryHash,
          dependencies: AuthRepositoryFamily._dependencies,
          allTransitiveDependencies:
              AuthRepositoryFamily._allTransitiveDependencies,
        );

  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  @override
  bool operator ==(Object other) {
    return other is AuthRepositoryProvider &&
        other.authRemoteDataSource == authRemoteDataSource &&
        other.networkInfo == networkInfo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, authRemoteDataSource.hashCode);
    hash = _SystemHash.combine(hash, networkInfo.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
