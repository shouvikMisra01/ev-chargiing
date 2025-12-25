import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../../../owner/domain/entities/provider_entity.dart';
import '../../../../shared/models/location.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/models/time_slot.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/station_remote_datasource.dart';

part 'map_providers.g.dart';

// Station Remote Data Source Provider
@riverpod
StationRemoteDataSource stationRemoteDataSource(StationRemoteDataSourceRef ref) {
  final dioClient = DioClient();
  return StationRemoteDataSourceImpl(dioClient: dioClient);
}

// Location State Provider
@riverpod
class UserLocation extends _$UserLocation {
  @override
  Future<Position?> build() async {
    return await _getCurrentLocation();
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> refreshLocation() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _getCurrentLocation());
  }
}

// Time Filter State
@riverpod
class TimeFilterState extends _$TimeFilterState {
  @override
  DateTime? build() {
    return null; // No time filter by default
  }

  void setTimeFilter(DateTime? time) {
    state = time;
  }

  void clearTimeFilter() {
    state = null;
  }
}

// Nearby Providers - Real API
@riverpod
class NearbyProviders extends _$NearbyProviders {
  @override
  Future<List<ProviderEntity>> build() async {
    // Get user's current location
    final locationAsync = ref.watch(userLocationProvider);

    return locationAsync.when(
      data: (position) async {
        if (position == null) {
          // No location permission, return empty list
          return [];
        }

        // Get time filter if set
        final timeFilter = ref.watch(timeFilterStateProvider);

        try {
          // Fetch stations from backend
          final dataSource = ref.watch(stationRemoteDataSourceProvider);
          final stations = await dataSource.searchStations(
            latitude: position.latitude,
            longitude: position.longitude,
            arrivalTime: timeFilter,
            chargingDurationHours: 2, // Default 2 hours
            radiusKm: 10.0, // 10km radius
          );
          return stations;
        } catch (e) {
          // If API fails, fall back to mock data for development
          return _getMockProviders();
        }
      },
      loading: () => _getMockProviders(), // Show mock data while loading location
      error: (_, __) => _getMockProviders(), // Show mock data on error
    );
  }

  // Fallback mock data for development/testing
  List<ProviderEntity> _getMockProviders() {
    final now = DateTime.now();

    return [
      ProviderEntity(
        id: '1',
        ownerId: 'owner1',
        ownerName: 'Rajesh Kumar',
        location: const Location(
          latitude: 28.6139,
          longitude: 77.2090,
          address: 'Connaught Place',
          city: 'New Delhi',
          state: 'Delhi',
          pincode: '110001',
        ),
        portType: ChargingPortType.type2,
        pricePerHour: 50.0,
        isOnline: true,
        isVerified: true,
        rating: 4.5,
        totalRatings: 120,
        totalBookings: 450,
        availableSlots: _generateTimeSlots(now),
      ),
      ProviderEntity(
        id: '2',
        ownerId: 'owner2',
        ownerName: 'Priya Sharma',
        location: const Location(
          latitude: 28.7041,
          longitude: 77.1025,
          address: 'Pitampura',
          city: 'New Delhi',
          state: 'Delhi',
          pincode: '110034',
        ),
        portType: ChargingPortType.ccs,
        pricePerHour: 60.0,
        isOnline: true,
        isVerified: true,
        rating: 4.8,
        totalRatings: 200,
        totalBookings: 680,
        availableSlots: _generateTimeSlots(now),
      ),
      ProviderEntity(
        id: '3',
        ownerId: 'owner3',
        ownerName: 'Amit Patel',
        location: const Location(
          latitude: 28.5355,
          longitude: 77.3910,
          address: 'Noida Sector 62',
          city: 'Noida',
          state: 'Uttar Pradesh',
          pincode: '201309',
        ),
        portType: ChargingPortType.type2,
        pricePerHour: 45.0,
        isOnline: true,
        isVerified: true,
        rating: 4.2,
        totalRatings: 85,
        totalBookings: 320,
        availableSlots: _generateTimeSlots(now),
      ),
      ProviderEntity(
        id: '4',
        ownerId: 'owner4',
        ownerName: 'Sneha Reddy',
        location: const Location(
          latitude: 28.4595,
          longitude: 77.0266,
          address: 'Gurgaon Cyber City',
          city: 'Gurgaon',
          state: 'Haryana',
          pincode: '122002',
        ),
        portType: ChargingPortType.chademo,
        pricePerHour: 70.0,
        isOnline: true,
        isVerified: true,
        rating: 4.9,
        totalRatings: 310,
        totalBookings: 920,
        availableSlots: _generateTimeSlots(now),
      ),
      ProviderEntity(
        id: '5',
        ownerId: 'owner5',
        ownerName: 'Vikram Singh',
        location: const Location(
          latitude: 28.6304,
          longitude: 77.2177,
          address: 'Lajpat Nagar',
          city: 'New Delhi',
          state: 'Delhi',
          pincode: '110024',
        ),
        portType: ChargingPortType.type2,
        pricePerHour: 55.0,
        isOnline: false,
        isVerified: true,
        rating: 4.0,
        totalRatings: 45,
        totalBookings: 180,
        availableSlots: [],
      ),
    ];
  }

  List<TimeSlot> _generateTimeSlots(DateTime now) {
    final slots = <TimeSlot>[];
    final today = DateTime(now.year, now.month, now.day);

    // Generate slots for next 7 days
    for (int day = 0; day < 7; day++) {
      final date = today.add(Duration(days: day));

      // Generate slots from 6 AM to 10 PM (4-hour slots)
      for (int hour = 6; hour < 22; hour += 4) {
        final startTime = date.add(Duration(hours: hour));
        final endTime = startTime.add(const Duration(hours: 4));

        // Skip past slots
        if (endTime.isAfter(now)) {
          slots.add(
            TimeSlot(
              id: 'slot_${day}_$hour',
              startTime: startTime,
              endTime: endTime,
              isBooked: false,
            ),
          );
        }
      }
    }

    return slots;
  }

  // Refresh providers (re-fetch from API)
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  // Search with custom parameters
  Future<void> searchWithFilters({
    DateTime? arrivalTime,
    int? chargingDurationHours,
    double? radiusKm,
    String? chargerType,
  }) async {
    state = const AsyncValue.loading();

    final locationAsync = ref.read(userLocationProvider);

    state = await AsyncValue.guard(() async {
      final position = locationAsync.value;
      if (position == null) {
        throw Exception('Location not available');
      }

      final dataSource = ref.read(stationRemoteDataSourceProvider);
      return await dataSource.searchStations(
        latitude: position.latitude,
        longitude: position.longitude,
        arrivalTime: arrivalTime,
        chargingDurationHours: chargingDurationHours,
        radiusKm: radiusKm,
        chargerType: chargerType,
      );
    });
  }

  // Get provider by ID
  Future<ProviderEntity?> getProviderById(String id) async {
    try {
      final dataSource = ref.read(stationRemoteDataSourceProvider);
      return await dataSource.getStationDetails(id);
    } catch (e) {
      // If API fails, check in current state
      return state.value?.firstWhere(
        (provider) => provider.id == id,
        orElse: () => throw Exception('Provider not found'),
      );
    }
  }
}

// Selected Provider
@riverpod
class SelectedProvider extends _$SelectedProvider {
  @override
  ProviderEntity? build() {
    return null;
  }

  void selectProvider(ProviderEntity? provider) {
    state = provider;
  }

  void clearSelection() {
    state = null;
  }
}
