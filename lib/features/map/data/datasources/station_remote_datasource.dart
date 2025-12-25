import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../owner/domain/entities/provider_entity.dart';
import '../../../../shared/models/location.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/models/time_slot.dart';

abstract class StationRemoteDataSource {
  Future<List<ProviderEntity>> searchStations({
    required double latitude,
    required double longitude,
    DateTime? arrivalTime,
    int? chargingDurationHours,
    double? radiusKm,
    String? chargerType,
  });

  Future<ProviderEntity> getStationDetails(String stationId);

  Future<List<TimeSlot>> getStationAvailability(String stationId);
}

class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  final DioClient dioClient;

  StationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ProviderEntity>> searchStations({
    required double latitude,
    required double longitude,
    DateTime? arrivalTime,
    int? chargingDurationHours,
    double? radiusKm,
    String? chargerType,
  }) async {
    final response = await dioClient.post(
      ApiEndpoints.searchStations,
      data: {
        'latitude': latitude,
        'longitude': longitude,
        if (arrivalTime != null) 'arrivalTime': arrivalTime.toIso8601String(),
        if (chargingDurationHours != null) 'chargingDuration': chargingDurationHours,
        if (radiusKm != null) 'radius': radiusKm,
        if (chargerType != null) 'chargerType': chargerType,
      },
    );

    final List<dynamic> stations = response.data['stations'] ?? response.data ?? [];
    return stations.map((json) => _parseStation(json)).toList();
  }

  @override
  Future<ProviderEntity> getStationDetails(String stationId) async {
    final response = await dioClient.get('${ApiEndpoints.getStation}/$stationId');
    return _parseStation(response.data);
  }

  @override
  Future<List<TimeSlot>> getStationAvailability(String stationId) async {
    final response = await dioClient.get(
      '${ApiEndpoints.getStationAvailability}/$stationId/availability',
    );

    final List<dynamic> slots = response.data['availableSlots'] ?? response.data ?? [];
    return slots.map((json) => _parseTimeSlot(json)).toList();
  }

  // Helper method to parse station from backend response
  ProviderEntity _parseStation(Map<String, dynamic> json) {
    return ProviderEntity(
      id: json['id'] ?? '',
      ownerId: json['owner_id'] ?? json['ownerId'] ?? '',
      ownerName: json['owner_name'] ?? json['ownerName'] ?? 'Unknown Owner',
      location: Location(
        latitude: (json['latitude'] ?? json['lat'] ?? 0.0).toDouble(),
        longitude: (json['longitude'] ?? json['lng'] ?? 0.0).toDouble(),
        address: json['address'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        pincode: json['pincode'] ?? '',
      ),
      portType: _parseChargingPortType(json['charger_type'] ?? json['chargerType']),
      pricePerHour: (json['price_per_hour'] ?? json['pricePerHour'] ?? 0.0).toDouble(),
      isOnline: json['is_online'] ?? json['isOnline'] ?? false,
      isVerified: json['is_verified'] ?? json['isVerified'] ?? false,
      rating: (json['rating'] ?? json['avg_rating'] ?? 0.0).toDouble(),
      totalRatings: json['total_ratings'] ?? json['totalRatings'] ?? 0,
      totalBookings: json['total_bookings'] ?? json['totalBookings'] ?? 0,
      availableSlots: json['available_slots'] != null
          ? (json['available_slots'] as List).map((slot) => _parseTimeSlot(slot)).toList()
          : [],
      // TODO: Add distanceKm field to ProviderEntity if needed
    );
  }

  // Helper method to parse time slot
  TimeSlot _parseTimeSlot(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'] ?? '',
      startTime: DateTime.parse(json['start_time'] ?? json['startTime']),
      endTime: DateTime.parse(json['end_time'] ?? json['endTime']),
      isBooked: json['is_booked'] ?? json['isBooked'] ?? false,
    );
  }

  // Helper method to parse charging port type
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
        return ChargingPortType.type2; // Default
    }
  }
}
