// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  Location get providerLocation => throw _privateConstructorUsedError;
  ChargingPortType get portType => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  double get pricePerHour => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  BookingStatus get status => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get confirmedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;

  /// Create a copy of BookingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingEntityCopyWith<BookingEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingEntityCopyWith<$Res> {
  factory $BookingEntityCopyWith(
          BookingEntity value, $Res Function(BookingEntity) then) =
      _$BookingEntityCopyWithImpl<$Res, BookingEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String providerId,
      String providerName,
      Location providerLocation,
      ChargingPortType portType,
      DateTime startTime,
      DateTime endTime,
      double pricePerHour,
      double totalAmount,
      BookingStatus status,
      String? cancellationReason,
      DateTime? createdAt,
      DateTime? confirmedAt,
      DateTime? cancelledAt});

  $LocationCopyWith<$Res> get providerLocation;
}

/// @nodoc
class _$BookingEntityCopyWithImpl<$Res, $Val extends BookingEntity>
    implements $BookingEntityCopyWith<$Res> {
  _$BookingEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? providerId = null,
    Object? providerName = null,
    Object? providerLocation = null,
    Object? portType = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? pricePerHour = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? cancellationReason = freezed,
    Object? createdAt = freezed,
    Object? confirmedAt = freezed,
    Object? cancelledAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      providerLocation: null == providerLocation
          ? _value.providerLocation
          : providerLocation // ignore: cast_nullable_to_non_nullable
              as Location,
      portType: null == portType
          ? _value.portType
          : portType // ignore: cast_nullable_to_non_nullable
              as ChargingPortType,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookingStatus,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of BookingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get providerLocation {
    return $LocationCopyWith<$Res>(_value.providerLocation, (value) {
      return _then(_value.copyWith(providerLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingEntityImplCopyWith<$Res>
    implements $BookingEntityCopyWith<$Res> {
  factory _$$BookingEntityImplCopyWith(
          _$BookingEntityImpl value, $Res Function(_$BookingEntityImpl) then) =
      __$$BookingEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String providerId,
      String providerName,
      Location providerLocation,
      ChargingPortType portType,
      DateTime startTime,
      DateTime endTime,
      double pricePerHour,
      double totalAmount,
      BookingStatus status,
      String? cancellationReason,
      DateTime? createdAt,
      DateTime? confirmedAt,
      DateTime? cancelledAt});

  @override
  $LocationCopyWith<$Res> get providerLocation;
}

/// @nodoc
class __$$BookingEntityImplCopyWithImpl<$Res>
    extends _$BookingEntityCopyWithImpl<$Res, _$BookingEntityImpl>
    implements _$$BookingEntityImplCopyWith<$Res> {
  __$$BookingEntityImplCopyWithImpl(
      _$BookingEntityImpl _value, $Res Function(_$BookingEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? providerId = null,
    Object? providerName = null,
    Object? providerLocation = null,
    Object? portType = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? pricePerHour = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? cancellationReason = freezed,
    Object? createdAt = freezed,
    Object? confirmedAt = freezed,
    Object? cancelledAt = freezed,
  }) {
    return _then(_$BookingEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      providerLocation: null == providerLocation
          ? _value.providerLocation
          : providerLocation // ignore: cast_nullable_to_non_nullable
              as Location,
      portType: null == portType
          ? _value.portType
          : portType // ignore: cast_nullable_to_non_nullable
              as ChargingPortType,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pricePerHour: null == pricePerHour
          ? _value.pricePerHour
          : pricePerHour // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookingStatus,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$BookingEntityImpl implements _BookingEntity {
  const _$BookingEntityImpl(
      {required this.id,
      required this.userId,
      required this.providerId,
      required this.providerName,
      required this.providerLocation,
      required this.portType,
      required this.startTime,
      required this.endTime,
      required this.pricePerHour,
      required this.totalAmount,
      required this.status,
      this.cancellationReason,
      this.createdAt,
      this.confirmedAt,
      this.cancelledAt});

  @override
  final String id;
  @override
  final String userId;
  @override
  final String providerId;
  @override
  final String providerName;
  @override
  final Location providerLocation;
  @override
  final ChargingPortType portType;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final double pricePerHour;
  @override
  final double totalAmount;
  @override
  final BookingStatus status;
  @override
  final String? cancellationReason;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? confirmedAt;
  @override
  final DateTime? cancelledAt;

  @override
  String toString() {
    return 'BookingEntity(id: $id, userId: $userId, providerId: $providerId, providerName: $providerName, providerLocation: $providerLocation, portType: $portType, startTime: $startTime, endTime: $endTime, pricePerHour: $pricePerHour, totalAmount: $totalAmount, status: $status, cancellationReason: $cancellationReason, createdAt: $createdAt, confirmedAt: $confirmedAt, cancelledAt: $cancelledAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.providerLocation, providerLocation) ||
                other.providerLocation == providerLocation) &&
            (identical(other.portType, portType) ||
                other.portType == portType) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.pricePerHour, pricePerHour) ||
                other.pricePerHour == pricePerHour) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      providerId,
      providerName,
      providerLocation,
      portType,
      startTime,
      endTime,
      pricePerHour,
      totalAmount,
      status,
      cancellationReason,
      createdAt,
      confirmedAt,
      cancelledAt);

  /// Create a copy of BookingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingEntityImplCopyWith<_$BookingEntityImpl> get copyWith =>
      __$$BookingEntityImplCopyWithImpl<_$BookingEntityImpl>(this, _$identity);
}

abstract class _BookingEntity implements BookingEntity {
  const factory _BookingEntity(
      {required final String id,
      required final String userId,
      required final String providerId,
      required final String providerName,
      required final Location providerLocation,
      required final ChargingPortType portType,
      required final DateTime startTime,
      required final DateTime endTime,
      required final double pricePerHour,
      required final double totalAmount,
      required final BookingStatus status,
      final String? cancellationReason,
      final DateTime? createdAt,
      final DateTime? confirmedAt,
      final DateTime? cancelledAt}) = _$BookingEntityImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get providerId;
  @override
  String get providerName;
  @override
  Location get providerLocation;
  @override
  ChargingPortType get portType;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  double get pricePerHour;
  @override
  double get totalAmount;
  @override
  BookingStatus get status;
  @override
  String? get cancellationReason;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get confirmedAt;
  @override
  DateTime? get cancelledAt;

  /// Create a copy of BookingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingEntityImplCopyWith<_$BookingEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
