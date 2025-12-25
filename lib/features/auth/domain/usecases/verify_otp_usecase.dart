import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String phoneNumber,
    required String otp,
  }) async {
    // Validate inputs
    if (phoneNumber.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Phone number is required'),
      );
    }

    if (otp.isEmpty) {
      return const Left(
        ValidationFailure(message: 'OTP is required'),
      );
    }

    if (otp.length != 6) {
      return const Left(
        ValidationFailure(message: 'OTP must be 6 digits'),
      );
    }

    return await repository.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );
  }
}
