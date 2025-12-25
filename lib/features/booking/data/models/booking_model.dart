import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/models/location.dart';
import '../../domain/entities/booking_entity.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
class BookingModel with _$BookingModel {
  const BookingModel._();

  const factory BookingModel({
    required String id,
    required String userId,
    required String providerId,
    required String providerName,
    required Location providerLocation,
    required String portType,
    required DateTime startTime,
    required DateTime endTime,
    required double pricePerHour,
    required double totalAmount,
    required String status,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? confirmedAt,
    DateTime? cancelledAt,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  // Convert to Domain Entity
  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      userId: userId,
      providerId: providerId,
      providerName: providerName,
      providerLocation: providerLocation,
      portType: ChargingPortType.fromString(portType),
      startTime: startTime,
      endTime: endTime,
      pricePerHour: pricePerHour,
      totalAmount: totalAmount,
      status: BookingStatus.fromString(status),
      cancellationReason: cancellationReason,
      createdAt: createdAt,
      confirmedAt: confirmedAt,
      cancelledAt: cancelledAt,
    );
  }

  // Create from Domain Entity
  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      userId: entity.userId,
      providerId: entity.providerId,
      providerName: entity.providerName,
      providerLocation: entity.providerLocation,
      portType: entity.portType.value,
      startTime: entity.startTime,
      endTime: entity.endTime,
      pricePerHour: entity.pricePerHour,
      totalAmount: entity.totalAmount,
      status: entity.status.value,
      cancellationReason: entity.cancellationReason,
      createdAt: entity.createdAt,
      confirmedAt: entity.confirmedAt,
      cancelledAt: entity.cancelledAt,
    );
  }
}
