import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot.freezed.dart';
part 'time_slot.g.dart';

@freezed
class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
    @Default(false) bool isBooked,
    String? bookedBy,
    String? bookingId,
  }) = _TimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
}

extension TimeSlotExtension on TimeSlot {
  bool get isAvailable => !isBooked && endTime.isAfter(DateTime.now());

  Duration get duration => endTime.difference(startTime);

  bool overlaps(TimeSlot other) {
    return startTime.isBefore(other.endTime) &&
        other.startTime.isBefore(endTime);
  }
}
