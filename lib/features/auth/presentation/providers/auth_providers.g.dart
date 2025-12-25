// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioClientHash() => r'8b2f86db76ff702eaf0eb16fd9c186e5d62db83e';

/// See also [dioClient].
@ProviderFor(dioClient)
final dioClientProvider = AutoDisposeProvider<DioClient>.internal(
  dioClient,
  name: r'dioClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioClientRef = AutoDisposeProviderRef<DioClient>;
String _$tokenServiceHash() => r'3f7c199dcab8f65045d080752d0fc6bbcc67e561';

/// See also [tokenService].
@ProviderFor(tokenService)
final tokenServiceProvider = AutoDisposeProvider<TokenService>.internal(
  tokenService,
  name: r'tokenServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tokenServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TokenServiceRef = AutoDisposeProviderRef<TokenService>;
String _$authRemoteDataSourceHash() =>
    r'f62f6990c206e668de5bd2f20e6cc64c7f4b2b63';

/// See also [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<AuthRemoteDataSource>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRemoteDataSourceRef = AutoDisposeProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'adf824091ebbd1fe256afd62e844b48b2e4865e4';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$sendOtpUseCaseHash() => r'fbd0c87c4dfe6467bb555b44ec7bcff159df4765';

/// See also [sendOtpUseCase].
@ProviderFor(sendOtpUseCase)
final sendOtpUseCaseProvider = AutoDisposeProvider<SendOtpUseCase>.internal(
  sendOtpUseCase,
  name: r'sendOtpUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendOtpUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendOtpUseCaseRef = AutoDisposeProviderRef<SendOtpUseCase>;
String _$verifyOtpUseCaseHash() => r'05aec30c3b50e51ce73ec7db4506db57803a0cf3';

/// See also [verifyOtpUseCase].
@ProviderFor(verifyOtpUseCase)
final verifyOtpUseCaseProvider = AutoDisposeProvider<VerifyOtpUseCase>.internal(
  verifyOtpUseCase,
  name: r'verifyOtpUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifyOtpUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VerifyOtpUseCaseRef = AutoDisposeProviderRef<VerifyOtpUseCase>;
String _$authStateHash() => r'8b579b83f1f8afd78d0ba83d266a5f8765090e35';

/// See also [AuthState].
@ProviderFor(AuthState)
final authStateProvider =
    AutoDisposeNotifierProvider<AuthState, AsyncValue<UserEntity?>>.internal(
  AuthState.new,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthState = AutoDisposeNotifier<AsyncValue<UserEntity?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
