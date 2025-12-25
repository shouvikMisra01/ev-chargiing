import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Send OTP to phone number
  Future<Either<Failure, String>> sendOtp(String phoneNumber);

  /// Verify OTP and get auth tokens
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  /// Get current authenticated user
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Update user profile
  Future<Either<Failure, UserEntity>> updateProfile({
    String? name,
    String? email,
    DateTime? dateOfBirth,
  });

  /// Select user role (after OTP verification)
  Future<Either<Failure, UserEntity>> selectRole(String role);

  /// Logout user
  Future<Either<Failure, void>> logout();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();
}
