// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingRemoteDataSourceHash() =>
    r'ddb977d5659d81095fee40d38890f7c00513ad9a';

/// See also [bookingRemoteDataSource].
@ProviderFor(bookingRemoteDataSource)
final bookingRemoteDataSourceProvider =
    AutoDisposeProvider<BookingRemoteDataSource>.internal(
  bookingRemoteDataSource,
  name: r'bookingRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingRemoteDataSourceRef
    = AutoDisposeProviderRef<BookingRemoteDataSource>;
String _$userBookingsHash() => r'68854d6378bedb58cef32e3080443b489bb458b3';

/// See also [UserBookings].
@ProviderFor(UserBookings)
final userBookingsProvider = AutoDisposeAsyncNotifierProvider<UserBookings,
    List<BookingEntity>>.internal(
  UserBookings.new,
  name: r'userBookingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userBookingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserBookings = AutoDisposeAsyncNotifier<List<BookingEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
