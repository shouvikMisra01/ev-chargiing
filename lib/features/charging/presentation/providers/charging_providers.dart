import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/charging_session_entity.dart';
import '../../../../shared/models/enums.dart';

part 'charging_providers.g.dart';

// Active Charging Session State
@riverpod
class ActiveChargingSession extends _$ActiveChargingSession {
  Timer? _timer;
  DateTime? _sessionStartTime;

  @override
  ChargingSessionEntity? build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return null;
  }

  Future<String?> startSession(String bookingId, String providerId) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _sessionStartTime = DateTime.now();

    state = ChargingSessionEntity(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      bookingId: bookingId,
      userId: 'user1',
      providerId: providerId,
      status: ChargingStatus.active,
      startTime: _sessionStartTime,
      createdAt: DateTime.now(),
    );

    // Start timer to update energy consumed
    _startTimer();

    return null; // No error
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state != null && state!.status == ChargingStatus.active) {
        // Simulate energy consumption (increase by ~0.1 kWh per minute)
        final currentSession = state!;
        final duration = DateTime.now().difference(currentSession.startTime!);
        final energyConsumed = (duration.inSeconds / 600).round(); // ~0.1 kWh per minute

        state = ChargingSessionEntity(
          id: currentSession.id,
          bookingId: currentSession.bookingId,
          userId: currentSession.userId,
          providerId: currentSession.providerId,
          status: currentSession.status,
          startTime: currentSession.startTime,
          endTime: currentSession.endTime,
          pausedAt: currentSession.pausedAt,
          energyConsumed: energyConsumed,
          finalAmount: currentSession.finalAmount,
          createdAt: currentSession.createdAt,
        );
      }
    });
  }

  Future<String?> pauseSession() async {
    if (state == null || !state!.canPause) {
      return 'Cannot pause session';
    }

    await Future.delayed(const Duration(milliseconds: 300));

    _timer?.cancel();

    state = ChargingSessionEntity(
      id: state!.id,
      bookingId: state!.bookingId,
      userId: state!.userId,
      providerId: state!.providerId,
      status: ChargingStatus.paused,
      startTime: state!.startTime,
      pausedAt: DateTime.now(),
      energyConsumed: state!.energyConsumed,
      createdAt: state!.createdAt,
    );

    return null;
  }

  Future<String?> resumeSession() async {
    if (state == null || !state!.canResume) {
      return 'Cannot resume session';
    }

    await Future.delayed(const Duration(milliseconds: 300));

    state = ChargingSessionEntity(
      id: state!.id,
      bookingId: state!.bookingId,
      userId: state!.userId,
      providerId: state!.providerId,
      status: ChargingStatus.active,
      startTime: state!.startTime,
      energyConsumed: state!.energyConsumed,
      createdAt: state!.createdAt,
    );

    _startTimer();

    return null;
  }

  Future<String?> endSession() async {
    if (state == null || !state!.canEnd) {
      return 'Cannot end session';
    }

    await Future.delayed(const Duration(seconds: 1));

    _timer?.cancel();

    final endTime = DateTime.now();
    // Calculate final amount: ₹10 per kWh
    final finalAmount = state!.energyConsumed * 10.0;

    state = ChargingSessionEntity(
      id: state!.id,
      bookingId: state!.bookingId,
      userId: state!.userId,
      providerId: state!.providerId,
      status: ChargingStatus.completed,
      startTime: state!.startTime,
      endTime: endTime,
      energyConsumed: state!.energyConsumed,
      finalAmount: finalAmount,
      createdAt: state!.createdAt,
    );

    return null;
  }

  void clearSession() {
    _timer?.cancel();
    state = null;
  }
}
