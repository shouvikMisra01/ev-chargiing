// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get bookingId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  PaymentMethod get method => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentEntityCopyWith<PaymentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentEntityCopyWith<$Res> {
  factory $PaymentEntityCopyWith(
          PaymentEntity value, $Res Function(PaymentEntity) then) =
      _$PaymentEntityCopyWithImpl<$Res, PaymentEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String bookingId,
      double amount,
      PaymentMethod method,
      PaymentStatus status,
      String? transactionId,
      String? failureReason,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class _$PaymentEntityCopyWithImpl<$Res, $Val extends PaymentEntity>
    implements $PaymentEntityCopyWith<$Res> {
  _$PaymentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookingId = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? transactionId = freezed,
    Object? failureReason = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
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
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentEntityImplCopyWith<$Res>
    implements $PaymentEntityCopyWith<$Res> {
  factory _$$PaymentEntityImplCopyWith(
          _$PaymentEntityImpl value, $Res Function(_$PaymentEntityImpl) then) =
      __$$PaymentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String bookingId,
      double amount,
      PaymentMethod method,
      PaymentStatus status,
      String? transactionId,
      String? failureReason,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$PaymentEntityImplCopyWithImpl<$Res>
    extends _$PaymentEntityCopyWithImpl<$Res, _$PaymentEntityImpl>
    implements _$$PaymentEntityImplCopyWith<$Res> {
  __$$PaymentEntityImplCopyWithImpl(
      _$PaymentEntityImpl _value, $Res Function(_$PaymentEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookingId = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? transactionId = freezed,
    Object? failureReason = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$PaymentEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$PaymentEntityImpl implements _PaymentEntity {
  const _$PaymentEntityImpl(
      {required this.id,
      required this.userId,
      required this.bookingId,
      required this.amount,
      required this.method,
      required this.status,
      this.transactionId,
      this.failureReason,
      this.createdAt,
      this.completedAt});

  @override
  final String id;
  @override
  final String userId;
  @override
  final String bookingId;
  @override
  final double amount;
  @override
  final PaymentMethod method;
  @override
  final PaymentStatus status;
  @override
  final String? transactionId;
  @override
  final String? failureReason;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'PaymentEntity(id: $id, userId: $userId, bookingId: $bookingId, amount: $amount, method: $method, status: $status, transactionId: $transactionId, failureReason: $failureReason, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, userId, bookingId, amount,
      method, status, transactionId, failureReason, createdAt, completedAt);

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentEntityImplCopyWith<_$PaymentEntityImpl> get copyWith =>
      __$$PaymentEntityImplCopyWithImpl<_$PaymentEntityImpl>(this, _$identity);
}

abstract class _PaymentEntity implements PaymentEntity {
  const factory _PaymentEntity(
      {required final String id,
      required final String userId,
      required final String bookingId,
      required final double amount,
      required final PaymentMethod method,
      required final PaymentStatus status,
      final String? transactionId,
      final String? failureReason,
      final DateTime? createdAt,
      final DateTime? completedAt}) = _$PaymentEntityImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get bookingId;
  @override
  double get amount;
  @override
  PaymentMethod get method;
  @override
  PaymentStatus get status;
  @override
  String? get transactionId;
  @override
  String? get failureReason;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentEntityImplCopyWith<_$PaymentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletEntityCopyWith<WalletEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletEntityCopyWith<$Res> {
  factory $WalletEntityCopyWith(
          WalletEntity value, $Res Function(WalletEntity) then) =
      _$WalletEntityCopyWithImpl<$Res, WalletEntity>;
  @useResult
  $Res call({String id, String userId, double balance, DateTime? lastUpdated});
}

/// @nodoc
class _$WalletEntityCopyWithImpl<$Res, $Val extends WalletEntity>
    implements $WalletEntityCopyWith<$Res> {
  _$WalletEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? balance = null,
    Object? lastUpdated = freezed,
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
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletEntityImplCopyWith<$Res>
    implements $WalletEntityCopyWith<$Res> {
  factory _$$WalletEntityImplCopyWith(
          _$WalletEntityImpl value, $Res Function(_$WalletEntityImpl) then) =
      __$$WalletEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userId, double balance, DateTime? lastUpdated});
}

/// @nodoc
class __$$WalletEntityImplCopyWithImpl<$Res>
    extends _$WalletEntityCopyWithImpl<$Res, _$WalletEntityImpl>
    implements _$$WalletEntityImplCopyWith<$Res> {
  __$$WalletEntityImplCopyWithImpl(
      _$WalletEntityImpl _value, $Res Function(_$WalletEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? balance = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$WalletEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$WalletEntityImpl implements _WalletEntity {
  const _$WalletEntityImpl(
      {required this.id,
      required this.userId,
      this.balance = 0.0,
      this.lastUpdated});

  @override
  final String id;
  @override
  final String userId;
  @override
  @JsonKey()
  final double balance;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'WalletEntity(id: $id, userId: $userId, balance: $balance, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, balance, lastUpdated);

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletEntityImplCopyWith<_$WalletEntityImpl> get copyWith =>
      __$$WalletEntityImplCopyWithImpl<_$WalletEntityImpl>(this, _$identity);
}

abstract class _WalletEntity implements WalletEntity {
  const factory _WalletEntity(
      {required final String id,
      required final String userId,
      final double balance,
      final DateTime? lastUpdated}) = _$WalletEntityImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  double get balance;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletEntityImplCopyWith<_$WalletEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get bookingId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of TransactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionEntityCopyWith<TransactionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionEntityCopyWith<$Res> {
  factory $TransactionEntityCopyWith(
          TransactionEntity value, $Res Function(TransactionEntity) then) =
      _$TransactionEntityCopyWithImpl<$Res, TransactionEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      double amount,
      TransactionType type,
      String description,
      String? bookingId,
      DateTime? createdAt});
}

/// @nodoc
class _$TransactionEntityCopyWithImpl<$Res, $Val extends TransactionEntity>
    implements $TransactionEntityCopyWith<$Res> {
  _$TransactionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? type = null,
    Object? description = null,
    Object? bookingId = freezed,
    Object? createdAt = freezed,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: freezed == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionEntityImplCopyWith<$Res>
    implements $TransactionEntityCopyWith<$Res> {
  factory _$$TransactionEntityImplCopyWith(_$TransactionEntityImpl value,
          $Res Function(_$TransactionEntityImpl) then) =
      __$$TransactionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      double amount,
      TransactionType type,
      String description,
      String? bookingId,
      DateTime? createdAt});
}

/// @nodoc
class __$$TransactionEntityImplCopyWithImpl<$Res>
    extends _$TransactionEntityCopyWithImpl<$Res, _$TransactionEntityImpl>
    implements _$$TransactionEntityImplCopyWith<$Res> {
  __$$TransactionEntityImplCopyWithImpl(_$TransactionEntityImpl _value,
      $Res Function(_$TransactionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? type = null,
    Object? description = null,
    Object? bookingId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$TransactionEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: freezed == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TransactionEntityImpl implements _TransactionEntity {
  const _$TransactionEntityImpl(
      {required this.id,
      required this.userId,
      required this.amount,
      required this.type,
      required this.description,
      this.bookingId,
      this.createdAt});

  @override
  final String id;
  @override
  final String userId;
  @override
  final double amount;
  @override
  final TransactionType type;
  @override
  final String description;
  @override
  final String? bookingId;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'TransactionEntity(id: $id, userId: $userId, amount: $amount, type: $type, description: $description, bookingId: $bookingId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, amount, type, description, bookingId, createdAt);

  /// Create a copy of TransactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionEntityImplCopyWith<_$TransactionEntityImpl> get copyWith =>
      __$$TransactionEntityImplCopyWithImpl<_$TransactionEntityImpl>(
          this, _$identity);
}

abstract class _TransactionEntity implements TransactionEntity {
  const factory _TransactionEntity(
      {required final String id,
      required final String userId,
      required final double amount,
      required final TransactionType type,
      required final String description,
      final String? bookingId,
      final DateTime? createdAt}) = _$TransactionEntityImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  double get amount;
  @override
  TransactionType get type;
  @override
  String get description;
  @override
  String? get bookingId;
  @override
  DateTime? get createdAt;

  /// Create a copy of TransactionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionEntityImplCopyWith<_$TransactionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
