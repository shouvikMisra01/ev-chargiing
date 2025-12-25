// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProviderEntity {
  String get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  Location get location => throw _privateConstructorUsedError;
  ChargingPortType get portType => throw _privateConstructorUsedError;
  double get pricePerHour => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  List<String> get equipmentImages => throw _privateConstructorUsedError;
  List<String> get parkingImages => throw _privateConstructorUsedError;
  List<TimeSlot> get availableSlots => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int? get totalRatings => throw _privateConstructorUsedError;
  int? get totalBookings => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of ProviderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProviderEntityCopyWith<ProviderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderEntityCopyWith<$Res> {
  factory $ProviderEntityCopyWith(
          ProviderEntity value, $Res Function(ProviderEntity) then) =
      _$ProviderEntityCopyWithImpl<$Res, ProviderEntity>;
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String ownerName,
      Location location,
      ChargingPortType portType,
      double pricePerHour,
      bool isOnline,
      bool isVerified,
      List<String> equipmentImages,
      List<String> parkingImages,
      List<TimeSlot> availableSlots,
      double? rating,
      int? totalRatings,
      int? totalBookings,
      DateTime? createdAt});

  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class _$ProviderEntityCopyWithImpl<$Res, $Val extends ProviderEntity>
    implements $ProviderEntityCopyWith<$Res> {
  _$ProviderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProviderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? ownerName = null,
    Object? location = null,
    Object? portType = null,
    Object? pricePerHour = null,
    Object? isOnline = null,
    Object? isVerified = null,
    Object? equipmentImages = null,
    Object? parkingImages = null,
    Object? availableSlots = null,
    Object? rating = freezed,
    Object? totalRatings = freezed,
    Object? totalBookings = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      portType: null == portType
          ? _value.portType
          : portType // ignore: cast_nullable_to_non_nullable
              as ChargingPortType,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      equipmentImages: null == equipmentImages
          ? _value.equipmentImages
          : equipmentImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parkingImages: null == parkingImages
          ? _value.parkingImages
          : parkingImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableSlots: null == availableSlots
          ? _value.availableSlots
          : availableSlots // ignore: cast_nullable_to_non_nullable
              as List<TimeSlot>,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRatings: freezed == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      totalBookings: freezed == totalBookings
          ? _value.totalBookings
          : totalBookings // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of ProviderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get location {
    return $LocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProviderEntityImplCopyWith<$Res>
    implements $ProviderEntityCopyWith<$Res> {
  factory _$$ProviderEntityImplCopyWith(_$ProviderEntityImpl value,
          $Res Function(_$ProviderEntityImpl) then) =
      __$$ProviderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String ownerName,
      Location location,
      ChargingPortType portType,
      double pricePerHour,
      bool isOnline,
      bool isVerified,
      List<String> equipmentImages,
      List<String> parkingImages,
      List<TimeSlot> availableSlots,
      double? rating,
      int? totalRatings,
      int? totalBookings,
      DateTime? createdAt});

  @override
  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$ProviderEntityImplCopyWithImpl<$Res>
    extends _$ProviderEntityCopyWithImpl<$Res, _$ProviderEntityImpl>
    implements _$$ProviderEntityImplCopyWith<$Res> {
  __$$ProviderEntityImplCopyWithImpl(
      _$ProviderEntityImpl _value, $Res Function(_$ProviderEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProviderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? ownerName = null,
    Object? location = null,
    Object? portType = null,
    Object? pricePerHour = null,
    Object? isOnline = null,
    Object? isVerified = null,
    Object? equipmentImages = null,
    Object? parkingImages = null,
    Object? availableSlots = null,
    Object? rating = freezed,
    Object? totalRatings = freezed,
    Object? totalBookings = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ProviderEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      portType: null == portType
          ? _value.portType
          : portType // ignore: cast_nullable_to_non_nullable
              as ChargingPortType,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      equipmentImages: null == equipmentImages
          ? _value._equipmentImages
          : equipmentImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parkingImages: null == parkingImages
          ? _value._parkingImages
          : parkingImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableSlots: null == availableSlots
          ? _value._availableSlots
          : availableSlots // ignore: cast_nullable_to_non_nullable
              as List<TimeSlot>,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRatings: freezed == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      totalBookings: freezed == totalBookings
          ? _value.totalBookings
          : totalBookings // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ProviderEntityImpl implements _ProviderEntity {
  const _$ProviderEntityImpl(
      {required this.id,
      required this.ownerId,
      required this.ownerName,
      required this.location,
      required this.portType,
      required this.pricePerHour,
      this.isOnline = false,
      this.isVerified = false,
      final List<String> equipmentImages = const [],
      final List<String> parkingImages = const [],
      final List<TimeSlot> availableSlots = const [],
      this.rating,
      this.totalRatings,
      this.totalBookings,
      this.createdAt})
      : _equipmentImages = equipmentImages,
        _parkingImages = parkingImages,
        _availableSlots = availableSlots;

  @override
  final String id;
  @override
  final String ownerId;
  @override
  final String ownerName;
  @override
  final Location location;
  @override
  final ChargingPortType portType;
  @override
  final double pricePerHour;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  @JsonKey()
  final bool isVerified;
  final List<String> _equipmentImages;
  @override
  @JsonKey()
  List<String> get equipmentImages {
    if (_equipmentImages is EqualUnmodifiableListView) return _equipmentImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipmentImages);
  }

  final List<String> _parkingImages;
  @override
  @JsonKey()
  List<String> get parkingImages {
    if (_parkingImages is EqualUnmodifiableListView) return _parkingImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parkingImages);
  }

  final List<TimeSlot> _availableSlots;
  @override
  @JsonKey()
  List<TimeSlot> get availableSlots {
    if (_availableSlots is EqualUnmodifiableListView) return _availableSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSlots);
  }

  @override
  final double? rating;
  @override
  final int? totalRatings;
  @override
  final int? totalBookings;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ProviderEntity(id: $id, ownerId: $ownerId, ownerName: $ownerName, location: $location, portType: $portType, pricePerHour: $pricePerHour, isOnline: $isOnline, isVerified: $isVerified, equipmentImages: $equipmentImages, parkingImages: $parkingImages, availableSlots: $availableSlots, rating: $rating, totalRatings: $totalRatings, totalBookings: $totalBookings, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.portType, portType) ||
                other.portType == portType) &&
            (identical(other.pricePerHour, pricePerHour) ||
                other.pricePerHour == pricePerHour) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            const DeepCollectionEquality()
                .equals(other._equipmentImages, _equipmentImages) &&
            const DeepCollectionEquality()
                .equals(other._parkingImages, _parkingImages) &&
            const DeepCollectionEquality()
                .equals(other._availableSlots, _availableSlots) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.totalBookings, totalBookings) ||
                other.totalBookings == totalBookings) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ownerId,
      ownerName,
      location,
      portType,
      pricePerHour,
      isOnline,
      isVerified,
      const DeepCollectionEquality().hash(_equipmentImages),
      const DeepCollectionEquality().hash(_parkingImages),
      const DeepCollectionEquality().hash(_availableSlots),
      rating,
      totalRatings,
      totalBookings,
      createdAt);

  /// Create a copy of ProviderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderEntityImplCopyWith<_$ProviderEntityImpl> get copyWith =>
      __$$ProviderEntityImplCopyWithImpl<_$ProviderEntityImpl>(
          this, _$identity);
}

abstract class _ProviderEntity implements ProviderEntity {
  const factory _ProviderEntity(
      {required final String id,
      required final String ownerId,
      required final String ownerName,
      required final Location location,
      required final ChargingPortType portType,
      required final double pricePerHour,
      final bool isOnline,
      final bool isVerified,
      final List<String> equipmentImages,
      final List<String> parkingImages,
      final List<TimeSlot> availableSlots,
      final double? rating,
      final int? totalRatings,
      final int? totalBookings,
      final DateTime? createdAt}) = _$ProviderEntityImpl;

  @override
  String get id;
  @override
  String get ownerId;
  @override
  String get ownerName;
  @override
  Location get location;
  @override
  ChargingPortType get portType;
  @override
  double get pricePerHour;
  @override
  bool get isOnline;
  @override
  bool get isVerified;
  @override
  List<String> get equipmentImages;
  @override
  List<String> get parkingImages;
  @override
  List<TimeSlot> get availableSlots;
  @override
  double? get rating;
  @override
  int? get totalRatings;
  @override
  int? get totalBookings;
  @override
  DateTime? get createdAt;

  /// Create a copy of ProviderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProviderEntityImplCopyWith<_$ProviderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
