import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';

part 'charging_session_entity.freezed.dart';

@freezed
class ChargingSessionEntity with _$ChargingSessionEntity {
  const ChargingSessionEntity._(); // Private constructor for extensions

  const factory ChargingSessionEntity({
    required String id,
    required String bookingId,
    required String userId,
    required String providerId,
    required ChargingStatus status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? pausedAt,
    @Default(0) int energyConsumed, // in kWh
    double? finalAmount,
    DateTime? createdAt,
  }) = _ChargingSessionEntity;

  // Instance getters (instead of extension)
  Duration? get duration {
    if (startTime == null) return null;
    final end = endTime ?? DateTime.now();
    return end.difference(startTime!);
  }

  bool get canPause => status == ChargingStatus.active;
  bool get canResume => status == ChargingStatus.paused;
  bool get canEnd => status == ChargingStatus.active || status == ChargingStatus.paused;
  bool get isActive => status == ChargingStatus.active;
  bool get isCompleted => status == ChargingStatus.completed;
}

