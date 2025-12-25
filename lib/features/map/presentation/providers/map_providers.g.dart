// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stationRemoteDataSourceHash() =>
    r'7fa9d087baab3fa0e8ca04226c19038bbd01ca38';

/// See also [stationRemoteDataSource].
@ProviderFor(stationRemoteDataSource)
final stationRemoteDataSourceProvider =
    AutoDisposeProvider<StationRemoteDataSource>.internal(
  stationRemoteDataSource,
  name: r'stationRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stationRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StationRemoteDataSourceRef
    = AutoDisposeProviderRef<StationRemoteDataSource>;
String _$userLocationHash() => r'171e6d89e7490e72d22cdfec680e29fecb4d3b9c';

/// See also [UserLocation].
@ProviderFor(UserLocation)
final userLocationProvider =
    AutoDisposeAsyncNotifierProvider<UserLocation, Position?>.internal(
  UserLocation.new,
  name: r'userLocationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserLocation = AutoDisposeAsyncNotifier<Position?>;
String _$timeFilterStateHash() => r'355367d5c37a3eacadc1a6ac4adf29d0d1d00117';

/// See also [TimeFilterState].
@ProviderFor(TimeFilterState)
final timeFilterStateProvider =
    AutoDisposeNotifierProvider<TimeFilterState, DateTime?>.internal(
  TimeFilterState.new,
  name: r'timeFilterStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timeFilterStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimeFilterState = AutoDisposeNotifier<DateTime?>;
String _$nearbyProvidersHash() => r'3ea0092d3de7e63896e2e117ba17f9ee7cabac7c';

/// See also [NearbyProviders].
@ProviderFor(NearbyProviders)
final nearbyProvidersProvider = AutoDisposeAsyncNotifierProvider<
    NearbyProviders, List<ProviderEntity>>.internal(
  NearbyProviders.new,
  name: r'nearbyProvidersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nearbyProvidersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NearbyProviders = AutoDisposeAsyncNotifier<List<ProviderEntity>>;
String _$selectedProviderHash() => r'84e86c7f3d22687df660e225f959867b46f88566';

/// See also [SelectedProvider].
@ProviderFor(SelectedProvider)
final selectedProviderProvider =
    AutoDisposeNotifierProvider<SelectedProvider, ProviderEntity?>.internal(
  SelectedProvider.new,
  name: r'selectedProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedProvider = AutoDisposeNotifier<ProviderEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
