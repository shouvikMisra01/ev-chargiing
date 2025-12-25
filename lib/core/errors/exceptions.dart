class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({
    this.message = 'No internet connection',
  });

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;

  AuthException({
    required this.message,
  });

  @override
  String toString() => 'AuthException: $message';
}

class ValidationException implements Exception {
  final String message;

  ValidationException({
    required this.message,
  });

  @override
  String toString() => 'ValidationException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = 'Cache error',
  });

  @override
  String toString() => 'CacheException: $message';
}

class PermissionException implements Exception {
  final String message;

  PermissionException({
    required this.message,
  });

  @override
  String toString() => 'PermissionException: $message';
}

class LocationException implements Exception {
  final String message;

  LocationException({
    this.message = 'Location error',
  });

  @override
  String toString() => 'LocationException: $message';
}

class PaymentException implements Exception {
  final String message;

  PaymentException({
    required this.message,
  });

  @override
  String toString() => 'PaymentException: $message';
}

class FileUploadException implements Exception {
  final String message;

  FileUploadException({
    this.message = 'File upload failed',
  });

  @override
  String toString() => 'FileUploadException: $message';
}
