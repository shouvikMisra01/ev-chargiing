import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/booking_entity.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/models/location.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/booking_remote_datasource.dart';

part 'booking_providers.g.dart';

// Booking Remote Data Source Provider
@riverpod
BookingRemoteDataSource bookingRemoteDataSource(BookingRemoteDataSourceRef ref) {
  final dioClient = DioClient();
  return BookingRemoteDataSourceImpl(dioClient: dioClient);
}

// User Bookings - Real API
@riverpod
class UserBookings extends _$UserBookings {
  @override
  Future<List<BookingEntity>> build() async {
    try {
      final dataSource = ref.watch(bookingRemoteDataSourceProvider);
      return await dataSource.getUserBookings();
    } catch (e) {
      // If API fails, fall back to mock data for development
      return _getMockBookings();
    }
  }

  List<BookingEntity> _getMockBookings() {
    final now = DateTime.now();

    return [
      // Upcoming booking
      BookingEntity(
        id: 'booking1',
        userId: 'user1',
        providerId: 'provider1',
        providerName: 'Rajesh Kumar',
        providerLocation: const Location(
          latitude: 28.6139,
          longitude: 77.2090,
          address: 'Connaught Place',
          city: 'New Delhi',
          state: 'Delhi',
          pincode: '110001',
        ),
        portType: ChargingPortType.type2,
        startTime: now.add(const Duration(hours: 2)),
        endTime: now.add(const Duration(hours: 4)),
        pricePerHour: 50.0,
        totalAmount: 100.0,
        status: BookingStatus.confirmed,
        createdAt: now.subtract(const Duration(hours: 1)),
        confirmedAt: now.subtract(const Duration(minutes: 50)),
      ),

      // Past completed booking
      BookingEntity(
        id: 'booking2',
        userId: 'user1',
        providerId: 'provider2',
        providerName: 'Priya Sharma',
        providerLocation: const Location(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Pitampura',
          city: 'New Delhi',
          state: 'Delhi',
          pincode: '110034',
        ),
        portType: ChargingPortType.ccs,
        startTime: now.subtract(const Duration(days: 2)),
        endTime: now.subtract(const Duration(days: 2, hours: -3)),
        pricePerHour: 60.0,
        totalAmount: 180.0,
        status: BookingStatus.completed,
        createdAt: now.subtract(const Duration(days: 3)),
        confirmedAt: now.subtract(const Duration(days: 3)),
      ),

      // Cancelled booking
      BookingEntity(
        id: 'booking3',
        userId: 'user1',
        providerId: 'provider3',
        providerName: 'Amit Patel',
        providerLocation: const Location(
          latitude: 28.5355,
          longitude: 77.3910,
          address: 'Noida Sector 62',
          city: 'Noida',
          state: 'Uttar Pradesh',
          pincode: '201309',
        ),
        portType: ChargingPortType.type2,
        startTime: now.subtract(const Duration(days: 5)),
        endTime: now.subtract(const Duration(days: 5, hours: -2)),
        pricePerHour: 45.0,
        totalAmount: 90.0,
        status: BookingStatus.cancelled,
        cancellationReason: 'Plan changed',
        createdAt: now.subtract(const Duration(days: 6)),
        cancelledAt: now.subtract(const Duration(days: 5, hours: 2)),
      ),
    ];
  }

  Future<String?> createBooking({
    required String providerId,
    required String providerName,
    required Location providerLocation,
    required ChargingPortType portType,
    required DateTime startTime,
    required DateTime endTime,
    required double pricePerHour,
  }) async {
    try {
      final dataSource = ref.read(bookingRemoteDataSourceProvider);
      final newBooking = await dataSource.createBooking(
        stationId: providerId,
        startTime: startTime,
        endTime: endTime,
      );

      // Update local state with new booking
      state = AsyncValue.data([newBooking, ...?state.value]);
      return null; // No error
    } catch (e) {
      return e.toString();
    }
  }

  // Refresh bookings from API
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  Future<String?> cancelBooking(String bookingId, String reason) async {
    try {
      final dataSource = ref.read(bookingRemoteDataSourceProvider);
      final updatedBooking = await dataSource.cancelBooking(bookingId, reason);

      // Update local state with cancelled booking
      final currentBookings = state.value ?? [];
      final bookingIndex = currentBookings.indexWhere((b) => b.id == bookingId);

      if (bookingIndex != -1) {
        final updatedList = [
          ...currentBookings.sublist(0, bookingIndex),
          updatedBooking,
          ...currentBookings.sublist(bookingIndex + 1),
        ];
        state = AsyncValue.data(updatedList);
      } else {
        // Booking not in local state, refresh from API
        await refresh();
      }

      return null; // No error
    } catch (e) {
      return e.toString();
    }
  }

  List<BookingEntity> get upcomingBookings {
    final bookings = state.value ?? [];
    return bookings.where((booking) => booking.isUpcoming).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  List<BookingEntity> get activeBookings {
    final bookings = state.value ?? [];
    return bookings.where((booking) => booking.isActive).toList();
  }

  List<BookingEntity> get pastBookings {
    final bookings = state.value ?? [];
    return bookings.where((booking) => booking.isPast).toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }

  BookingEntity? getBookingById(String id) {
    try {
      final bookings = state.value ?? [];
      return bookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }
}
