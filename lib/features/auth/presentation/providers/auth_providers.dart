import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/token_service.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

part 'auth_providers.g.dart';

// Dependency Providers

@riverpod
DioClient dioClient(DioClientRef ref) {
  return DioClient();
}

@riverpod
TokenService tokenService(TokenServiceRef ref) {
  return TokenService();
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSourceImpl(
    dioClient: ref.watch(dioClientProvider),
    tokenService: ref.watch(tokenServiceProvider),
  );
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenService: ref.watch(tokenServiceProvider),
  );
}

// Use Case Providers

@riverpod
SendOtpUseCase sendOtpUseCase(SendOtpUseCaseRef ref) {
  return SendOtpUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
VerifyOtpUseCase verifyOtpUseCase(VerifyOtpUseCaseRef ref) {
  return VerifyOtpUseCase(ref.watch(authRepositoryProvider));
}

// Auth State Provider

@riverpod
class AuthState extends _$AuthState {
  @override
  AsyncValue<UserEntity?> build() {
    // Check if user is authenticated on app start
    _checkAuthStatus();
    return const AsyncValue.loading();
  }

  Future<void> _checkAuthStatus() async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    final isAuth = await repository.isAuthenticated();

    if (isAuth) {
      final result = await repository.getCurrentUser();
      state = result.fold(
        (failure) {
          // If token is invalid/expired, treat as not authenticated
          return const AsyncValue.data(null);
        },
        (user) => AsyncValue.data(user),
      );
    } else {
      state = const AsyncValue.data(null);
    }
  }

  Future<String?> sendOtp(String phoneNumber) async {
    final useCase = ref.read(sendOtpUseCaseProvider);
    final result = await useCase(phoneNumber);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return failure.message;
      },
      (message) => null, // Success, no error
    );
  }

  Future<String?> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(verifyOtpUseCaseProvider);
    final result = await useCase(phoneNumber: phoneNumber, otp: otp);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return failure.message;
      },
      (user) {
        state = AsyncValue.data(user);
        return null; // Success, no error
      },
    );
  }

  Future<String?> selectRole(String role) async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.selectRole(role);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return failure.message;
      },
      (user) {
        state = AsyncValue.data(user);
        return null; // Success
      },
    );
  }

  Future<String?> updateProfile({
    String? name,
    String? email,
    DateTime? dateOfBirth,
  }) async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.updateProfile(
      name: name,
      email: email,
      dateOfBirth: dateOfBirth,
    );

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return failure.message;
      },
      (user) {
        state = AsyncValue.data(user);
        return null; // Success
      },
    );
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();
    state = const AsyncValue.data(null);
  }
}
