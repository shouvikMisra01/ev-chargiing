import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';

part 'payment_entity.freezed.dart';

@freezed
class PaymentEntity with _$PaymentEntity {
  const factory PaymentEntity({
    required String id,
    required String userId,
    required String bookingId,
    required double amount,
    required PaymentMethod method,
    required PaymentStatus status,
    String? transactionId,
    String? failureReason,
    DateTime? createdAt,
    DateTime? completedAt,
  }) = _PaymentEntity;
}

@freezed
class WalletEntity with _$WalletEntity {
  const factory WalletEntity({
    required String id,
    required String userId,
    @Default(0.0) double balance,
    DateTime? lastUpdated,
  }) = _WalletEntity;
}

@freezed
class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,
    required String userId,
    required double amount,
    required TransactionType type,
    required String description,
    String? bookingId,
    DateTime? createdAt,
  }) = _TransactionEntity;
}

extension PaymentEntityExtension on PaymentEntity {
  bool get isPending => status == PaymentStatus.pending;

  bool get isSuccess => status == PaymentStatus.success;

  bool get isFailed => status == PaymentStatus.failed;

  bool get canRetry => status == PaymentStatus.failed;
}
