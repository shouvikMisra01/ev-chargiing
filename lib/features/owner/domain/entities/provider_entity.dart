import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/models/location.dart';
import '../../../../shared/models/time_slot.dart';

part 'provider_entity.freezed.dart';

@freezed
class ProviderEntity with _$ProviderEntity {
  const factory ProviderEntity({
    required String id,
    required String ownerId,
    required String ownerName,
    required Location location,
    required ChargingPortType portType,
    required double pricePerHour,
    @Default(false) bool isOnline,
    @Default(false) bool isVerified,
    @Default([]) List<String> equipmentImages,
    @Default([]) List<String> parkingImages,
    @Default([]) List<TimeSlot> availableSlots,
    double? rating,
    int? totalRatings,
    int? totalBookings,
    DateTime? createdAt,
  }) = _ProviderEntity;
}

extension ProviderEntityExtension on ProviderEntity {
  bool get canAcceptBookings => isOnline && isVerified;

  List<TimeSlot> getAvailableSlots(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return availableSlots
        .where((slot) =>
            slot.isAvailable &&
            slot.startTime.isAfter(startOfDay) &&
            slot.startTime.isBefore(endOfDay))
        .toList();
  }
}
