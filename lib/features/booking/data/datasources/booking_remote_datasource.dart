import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/booking_entity.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/models/location.dart';

abstract class BookingRemoteDataSource {
  Future<BookingEntity> createBooking({
    required String stationId,
    required DateTime startTime,
    required DateTime endTime,
  });

  Future<List<BookingEntity>> getUserBookings();

  Future<BookingEntity> getBookingById(String bookingId);

  Future<BookingEntity> cancelBooking(String bookingId, String reason);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final DioClient dioClient;

  BookingRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<BookingEntity> createBooking({
    required String stationId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final response = await dioClient.post(
      ApiEndpoints.createBooking,
      data: {
        'stationId': stationId,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
      },
    );

    return _parseBooking(response.data['booking'] ?? response.data);
  }

  @override
  Future<List<BookingEntity>> getUserBookings() async {
    final response = await dioClient.get(ApiEndpoints.getUserBookings);

    final List<dynamic> bookings = response.data['bookings'] ?? response.data ?? [];
    return bookings.map((json) => _parseBooking(json)).toList();
  }

  @override
  Future<BookingEntity> getBookingById(String bookingId) async {
    final response = await dioClient.get('${ApiEndpoints.getBooking}/$bookingId');
    return _parseBooking(response.data);
  }

  @override
  Future<BookingEntity> cancelBooking(String bookingId, String reason) async {
    final response = await dioClient.put(
      '${ApiEndpoints.cancelBooking}/$bookingId/cancel',
      data: {'reason': reason},
    );

    return _parseBooking(response.data['booking'] ?? response.data);
  }

  // Helper method to parse booking from backend response
  BookingEntity _parseBooking(Map<String, dynamic> json) {
    return BookingEntity(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? json['userId'] ?? '',
      providerId: json['station_id'] ?? json['stationId'] ?? json['providerId'] ?? '',
      providerName: json['station_name'] ?? json['stationName'] ?? json['providerName'] ?? 'Unknown Station',
      providerLocation: _parseLocation(json),
      portType: _parseChargingPortType(json['charger_type'] ?? json['chargerType'] ?? json['portType']),
      startTime: DateTime.parse(json['start_time'] ?? json['startTime']),
      endTime: DateTime.parse(json['end_time'] ?? json['endTime']),
      pricePerHour: (json['price_per_hour'] ?? json['pricePerHour'] ?? 0.0).toDouble(),
      totalAmount: (json['total_amount'] ?? json['totalAmount'] ?? 0.0).toDouble(),
      status: _parseBookingStatus(json['status']),
      cancellationReason: json['cancellation_reason'] ?? json['cancellationReason'],
      createdAt: DateTime.parse(json['created_at'] ?? json['createdAt'] ?? DateTime.now().toIso8601String()),
      confirmedAt: json['confirmed_at'] != null || json['confirmedAt'] != null
          ? DateTime.parse(json['confirmed_at'] ?? json['confirmedAt'])
          : null,
      cancelledAt: json['cancelled_at'] != null || json['cancelledAt'] != null
          ? DateTime.parse(json['cancelled_at'] ?? json['cancelledAt'])
          : null,
    );
  }

  // Helper to parse location
  Location _parseLocation(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] ?? json['lat'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? json['lng'] ?? 0.0).toDouble(),
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }

  // Helper to parse booking status
  BookingStatus _parseBookingStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'PENDING':
        return BookingStatus.pending;
      case 'CONFIRMED':
        return BookingStatus.confirmed;
      case 'ACTIVE':
      case 'IN_PROGRESS':
        return BookingStatus.active;
      case 'COMPLETED':
        return BookingStatus.completed;
      case 'CANCELLED':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }

  // Helper to parse charging port type
  ChargingPortType _parseChargingPortType(String? type) {
    switch (type?.toUpperCase()) {
      case 'TYPE1':
        return ChargingPortType.type1;
      case 'TYPE2':
        return ChargingPortType.type2;
      case 'CCS':
        return ChargingPortType.ccs;
      case 'CHADEMO':
        return ChargingPortType.chademo;
      case 'GB/T':
      case 'GBT':
        return ChargingPortType.gbt;
      default:
        return ChargingPortType.type2;
    }
  }
}
