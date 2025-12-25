import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/models/location.dart';

part 'booking_entity.freezed.dart';

@freezed
class BookingEntity with _$BookingEntity {
  const factory BookingEntity({
    required String id,
    required String userId,
    required String providerId,
    required String providerName,
    required Location providerLocation,
    required ChargingPortType portType,
    required DateTime startTime,
    required DateTime endTime,
    required double pricePerHour,
    required double totalAmount,
    required BookingStatus status,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? confirmedAt,
    DateTime? cancelledAt,
  }) = _BookingEntity;
}

extension BookingEntityExtension on BookingEntity {
  Duration get duration => endTime.difference(startTime);

  bool get canCancel =>
      status == BookingStatus.pending || status == BookingStatus.confirmed;

  bool get canStartCharging =>
      status == BookingStatus.confirmed &&
      DateTime.now().isAfter(startTime.subtract(const Duration(minutes: 15))) &&
      DateTime.now().isBefore(endTime);

  bool get isUpcoming =>
      (status == BookingStatus.pending || status == BookingStatus.confirmed) &&
      startTime.isAfter(DateTime.now());

  bool get isActive =>
      status == BookingStatus.active ||
      (status == BookingStatus.confirmed &&
          DateTime.now().isAfter(startTime) &&
          DateTime.now().isBefore(endTime));

  bool get isPast =>
      status == BookingStatus.completed ||
      status == BookingStatus.cancelled ||
      endTime.isBefore(DateTime.now());
}
