import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<Either<Failure, String>> call(String phoneNumber) async {
    // Validate phone number format
    if (phoneNumber.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Phone number is required'),
      );
    }

    // Clean phone number
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // Validate Indian phone number
    if (!RegExp(r'^(\+91)?[6-9]\d{9}$').hasMatch(cleaned)) {
      return const Left(
        ValidationFailure(message: 'Invalid phone number format'),
      );
    }

    return await repository.sendOtp(cleaned);
  }
}
