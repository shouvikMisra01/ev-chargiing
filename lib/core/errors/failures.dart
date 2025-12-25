import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
    super.code,
  });
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to load cached data',
    super.code,
  });
}

// Permission Failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
  });
}

// Location Failures
class LocationFailure extends Failure {
  const LocationFailure({
    super.message = 'Unable to fetch location',
    super.code,
  });
}

// Payment Failures
class PaymentFailure extends Failure {
  const PaymentFailure({
    required super.message,
    super.code,
  });
}

// Booking Failures
class BookingFailure extends Failure {
  const BookingFailure({
    required super.message,
    super.code,
  });
}

// File Upload Failures
class FileUploadFailure extends Failure {
  const FileUploadFailure({
    super.message = 'Failed to upload file',
    super.code,
  });
}

// Unknown Failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred',
    super.code,
  });
}
