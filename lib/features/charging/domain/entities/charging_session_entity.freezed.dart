// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'charging_session_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChargingSessionEntity {
  String get id => throw _privateConstructorUsedError;
  String get bookingId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  ChargingStatus get status => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  DateTime? get pausedAt => throw _privateConstructorUsedError;
  int get energyConsumed => throw _privateConstructorUsedError; // in kWh
  double? get finalAmount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of ChargingSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChargingSessionEntityCopyWith<ChargingSessionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChargingSessionEntityCopyWith<$Res> {
  factory $ChargingSessionEntityCopyWith(ChargingSessionEntity value,
          $Res Function(ChargingSessionEntity) then) =
      _$ChargingSessionEntityCopyWithImpl<$Res, ChargingSessionEntity>;
  @useResult
  $Res call(
      {String id,
      String bookingId,
      String userId,
      String providerId,
      ChargingStatus status,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? pausedAt,
      int energyConsumed,
      double? finalAmount,
      DateTime? createdAt});
}

/// @nodoc
class _$ChargingSessionEntityCopyWithImpl<$Res,
        $Val extends ChargingSessionEntity>
    implements $ChargingSessionEntityCopyWith<$Res> {
  _$ChargingSessionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChargingSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? userId = null,
    Object? providerId = null,
    Object? status = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? pausedAt = freezed,
    Object? energyConsumed = null,
    Object? finalAmount = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChargingStatus,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pausedAt: freezed == pausedAt
          ? _value.pausedAt
          : pausedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      energyConsumed: null == energyConsumed
          ? _value.energyConsumed
          : energyConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChargingSessionEntityImplCopyWith<$Res>
    implements $ChargingSessionEntityCopyWith<$Res> {
  factory _$$ChargingSessionEntityImplCopyWith(
          _$ChargingSessionEntityImpl value,
          $Res Function(_$ChargingSessionEntityImpl) then) =
      __$$ChargingSessionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bookingId,
      String userId,
      String providerId,
      ChargingStatus status,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? pausedAt,
      int energyConsumed,
      double? finalAmount,
      DateTime? createdAt});
}

/// @nodoc
class __$$ChargingSessionEntityImplCopyWithImpl<$Res>
    extends _$ChargingSessionEntityCopyWithImpl<$Res,
        _$ChargingSessionEntityImpl>
    implements _$$ChargingSessionEntityImplCopyWith<$Res> {
  __$$ChargingSessionEntityImplCopyWithImpl(_$ChargingSessionEntityImpl _value,
      $Res Function(_$ChargingSessionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChargingSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? userId = null,
    Object? providerId = null,
    Object? status = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? pausedAt = freezed,
    Object? energyConsumed = null,
    Object? finalAmount = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChargingSessionEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChargingStatus,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pausedAt: freezed == pausedAt
          ? _value.pausedAt
          : pausedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      energyConsumed: null == energyConsumed
          ? _value.energyConsumed
          : energyConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ChargingSessionEntityImpl extends _ChargingSessionEntity {
  const _$ChargingSessionEntityImpl(
      {required this.id,
      required this.bookingId,
      required this.userId,
      required this.providerId,
      required this.status,
      this.startTime,
      this.endTime,
      this.pausedAt,
      this.energyConsumed = 0,
      this.finalAmount,
      this.createdAt})
      : super._();

  @override
  final String id;
  @override
  final String bookingId;
  @override
  final String userId;
  @override
  final String providerId;
  @override
  final ChargingStatus status;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final DateTime? pausedAt;
  @override
  @JsonKey()
  final int energyConsumed;
// in kWh
  @override
  final double? finalAmount;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ChargingSessionEntity(id: $id, bookingId: $bookingId, userId: $userId, providerId: $providerId, status: $status, startTime: $startTime, endTime: $endTime, pausedAt: $pausedAt, energyConsumed: $energyConsumed, finalAmount: $finalAmount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChargingSessionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.pausedAt, pausedAt) ||
                other.pausedAt == pausedAt) &&
            (identical(other.energyConsumed, energyConsumed) ||
                other.energyConsumed == energyConsumed) &&
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      bookingId,
      userId,
      providerId,
      status,
      startTime,
      endTime,
      pausedAt,
      energyConsumed,
      finalAmount,
      createdAt);

  /// Create a copy of ChargingSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChargingSessionEntityImplCopyWith<_$ChargingSessionEntityImpl>
      get copyWith => __$$ChargingSessionEntityImplCopyWithImpl<
          _$ChargingSessionEntityImpl>(this, _$identity);
}

abstract class _ChargingSessionEntity extends ChargingSessionEntity {
  const factory _ChargingSessionEntity(
      {required final String id,
      required final String bookingId,
      required final String userId,
      required final String providerId,
      required final ChargingStatus status,
      final DateTime? startTime,
      final DateTime? endTime,
      final DateTime? pausedAt,
      final int energyConsumed,
      final double? finalAmount,
      final DateTime? createdAt}) = _$ChargingSessionEntityImpl;
  const _ChargingSessionEntity._() : super._();

  @override
  String get id;
  @override
  String get bookingId;
  @override
  String get userId;
  @override
  String get providerId;
  @override
  ChargingStatus get status;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  DateTime? get pausedAt;
  @override
  int get energyConsumed; // in kWh
  @override
  double? get finalAmount;
  @override
  DateTime? get createdAt;

  /// Create a copy of ChargingSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChargingSessionEntityImplCopyWith<_$ChargingSessionEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
