// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RatingEntity {
  String get id => throw _privateConstructorUsedError;
  String get bookingId => throw _privateConstructorUsedError;
  String get raterId =>
      throw _privateConstructorUsedError; // Who gave the rating
  String get rateeId =>
      throw _privateConstructorUsedError; // Who received the rating
  double get rating => throw _privateConstructorUsedError; // 1-5
  String? get review => throw _privateConstructorUsedError;
  List<String> get tags =>
      throw _privateConstructorUsedError; // e.g., "Clean", "Fast", "Helpful"
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of RatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingEntityCopyWith<RatingEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingEntityCopyWith<$Res> {
  factory $RatingEntityCopyWith(
          RatingEntity value, $Res Function(RatingEntity) then) =
      _$RatingEntityCopyWithImpl<$Res, RatingEntity>;
  @useResult
  $Res call(
      {String id,
      String bookingId,
      String raterId,
      String rateeId,
      double rating,
      String? review,
      List<String> tags,
      DateTime? createdAt});
}

/// @nodoc
class _$RatingEntityCopyWithImpl<$Res, $Val extends RatingEntity>
    implements $RatingEntityCopyWith<$Res> {
  _$RatingEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? raterId = null,
    Object? rateeId = null,
    Object? rating = null,
    Object? review = freezed,
    Object? tags = null,
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
      raterId: null == raterId
          ? _value.raterId
          : raterId // ignore: cast_nullable_to_non_nullable
              as String,
      rateeId: null == rateeId
          ? _value.rateeId
          : rateeId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatingEntityImplCopyWith<$Res>
    implements $RatingEntityCopyWith<$Res> {
  factory _$$RatingEntityImplCopyWith(
          _$RatingEntityImpl value, $Res Function(_$RatingEntityImpl) then) =
      __$$RatingEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bookingId,
      String raterId,
      String rateeId,
      double rating,
      String? review,
      List<String> tags,
      DateTime? createdAt});
}

/// @nodoc
class __$$RatingEntityImplCopyWithImpl<$Res>
    extends _$RatingEntityCopyWithImpl<$Res, _$RatingEntityImpl>
    implements _$$RatingEntityImplCopyWith<$Res> {
  __$$RatingEntityImplCopyWithImpl(
      _$RatingEntityImpl _value, $Res Function(_$RatingEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of RatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? raterId = null,
    Object? rateeId = null,
    Object? rating = null,
    Object? review = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$RatingEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      raterId: null == raterId
          ? _value.raterId
          : raterId // ignore: cast_nullable_to_non_nullable
              as String,
      rateeId: null == rateeId
          ? _value.rateeId
          : rateeId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$RatingEntityImpl implements _RatingEntity {
  const _$RatingEntityImpl(
      {required this.id,
      required this.bookingId,
      required this.raterId,
      required this.rateeId,
      required this.rating,
      this.review,
      final List<String> tags = const [],
      this.createdAt})
      : _tags = tags;

  @override
  final String id;
  @override
  final String bookingId;
  @override
  final String raterId;
// Who gave the rating
  @override
  final String rateeId;
// Who received the rating
  @override
  final double rating;
// 1-5
  @override
  final String? review;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

// e.g., "Clean", "Fast", "Helpful"
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'RatingEntity(id: $id, bookingId: $bookingId, raterId: $raterId, rateeId: $rateeId, rating: $rating, review: $review, tags: $tags, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.raterId, raterId) || other.raterId == raterId) &&
            (identical(other.rateeId, rateeId) || other.rateeId == rateeId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.review, review) || other.review == review) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, bookingId, raterId, rateeId,
      rating, review, const DeepCollectionEquality().hash(_tags), createdAt);

  /// Create a copy of RatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingEntityImplCopyWith<_$RatingEntityImpl> get copyWith =>
      __$$RatingEntityImplCopyWithImpl<_$RatingEntityImpl>(this, _$identity);
}

abstract class _RatingEntity implements RatingEntity {
  const factory _RatingEntity(
      {required final String id,
      required final String bookingId,
      required final String raterId,
      required final String rateeId,
      required final double rating,
      final String? review,
      final List<String> tags,
      final DateTime? createdAt}) = _$RatingEntityImpl;

  @override
  String get id;
  @override
  String get bookingId;
  @override
  String get raterId; // Who gave the rating
  @override
  String get rateeId; // Who received the rating
  @override
  double get rating; // 1-5
  @override
  String? get review;
  @override
  List<String> get tags; // e.g., "Clean", "Fast", "Helpful"
  @override
  DateTime? get createdAt;

  /// Create a copy of RatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingEntityImplCopyWith<_$RatingEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserRatingStatsEntity {
  String get userId => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalRatings => throw _privateConstructorUsedError;
  int get fiveStarCount => throw _privateConstructorUsedError;
  int get fourStarCount => throw _privateConstructorUsedError;
  int get threeStarCount => throw _privateConstructorUsedError;
  int get twoStarCount => throw _privateConstructorUsedError;
  int get oneStarCount => throw _privateConstructorUsedError;

  /// Create a copy of UserRatingStatsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRatingStatsEntityCopyWith<UserRatingStatsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRatingStatsEntityCopyWith<$Res> {
  factory $UserRatingStatsEntityCopyWith(UserRatingStatsEntity value,
          $Res Function(UserRatingStatsEntity) then) =
      _$UserRatingStatsEntityCopyWithImpl<$Res, UserRatingStatsEntity>;
  @useResult
  $Res call(
      {String userId,
      double averageRating,
      int totalRatings,
      int fiveStarCount,
      int fourStarCount,
      int threeStarCount,
      int twoStarCount,
      int oneStarCount});
}

/// @nodoc
class _$UserRatingStatsEntityCopyWithImpl<$Res,
        $Val extends UserRatingStatsEntity>
    implements $UserRatingStatsEntityCopyWith<$Res> {
  _$UserRatingStatsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRatingStatsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? averageRating = null,
    Object? totalRatings = null,
    Object? fiveStarCount = null,
    Object? fourStarCount = null,
    Object? threeStarCount = null,
    Object? twoStarCount = null,
    Object? oneStarCount = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      fiveStarCount: null == fiveStarCount
          ? _value.fiveStarCount
          : fiveStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      fourStarCount: null == fourStarCount
          ? _value.fourStarCount
          : fourStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      threeStarCount: null == threeStarCount
          ? _value.threeStarCount
          : threeStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      twoStarCount: null == twoStarCount
          ? _value.twoStarCount
          : twoStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      oneStarCount: null == oneStarCount
          ? _value.oneStarCount
          : oneStarCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserRatingStatsEntityImplCopyWith<$Res>
    implements $UserRatingStatsEntityCopyWith<$Res> {
  factory _$$UserRatingStatsEntityImplCopyWith(
          _$UserRatingStatsEntityImpl value,
          $Res Function(_$UserRatingStatsEntityImpl) then) =
      __$$UserRatingStatsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      double averageRating,
      int totalRatings,
      int fiveStarCount,
      int fourStarCount,
      int threeStarCount,
      int twoStarCount,
      int oneStarCount});
}

/// @nodoc
class __$$UserRatingStatsEntityImplCopyWithImpl<$Res>
    extends _$UserRatingStatsEntityCopyWithImpl<$Res,
        _$UserRatingStatsEntityImpl>
    implements _$$UserRatingStatsEntityImplCopyWith<$Res> {
  __$$UserRatingStatsEntityImplCopyWithImpl(_$UserRatingStatsEntityImpl _value,
      $Res Function(_$UserRatingStatsEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRatingStatsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? averageRating = null,
    Object? totalRatings = null,
    Object? fiveStarCount = null,
    Object? fourStarCount = null,
    Object? threeStarCount = null,
    Object? twoStarCount = null,
    Object? oneStarCount = null,
  }) {
    return _then(_$UserRatingStatsEntityImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      fiveStarCount: null == fiveStarCount
          ? _value.fiveStarCount
          : fiveStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      fourStarCount: null == fourStarCount
          ? _value.fourStarCount
          : fourStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      threeStarCount: null == threeStarCount
          ? _value.threeStarCount
          : threeStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      twoStarCount: null == twoStarCount
          ? _value.twoStarCount
          : twoStarCount // ignore: cast_nullable_to_non_nullable
              as int,
      oneStarCount: null == oneStarCount
          ? _value.oneStarCount
          : oneStarCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserRatingStatsEntityImpl implements _UserRatingStatsEntity {
  const _$UserRatingStatsEntityImpl(
      {required this.userId,
      this.averageRating = 0.0,
      this.totalRatings = 0,
      this.fiveStarCount = 0,
      this.fourStarCount = 0,
      this.threeStarCount = 0,
      this.twoStarCount = 0,
      this.oneStarCount = 0});

  @override
  final String userId;
  @override
  @JsonKey()
  final double averageRating;
  @override
  @JsonKey()
  final int totalRatings;
  @override
  @JsonKey()
  final int fiveStarCount;
  @override
  @JsonKey()
  final int fourStarCount;
  @override
  @JsonKey()
  final int threeStarCount;
  @override
  @JsonKey()
  final int twoStarCount;
  @override
  @JsonKey()
  final int oneStarCount;

  @override
  String toString() {
    return 'UserRatingStatsEntity(userId: $userId, averageRating: $averageRating, totalRatings: $totalRatings, fiveStarCount: $fiveStarCount, fourStarCount: $fourStarCount, threeStarCount: $threeStarCount, twoStarCount: $twoStarCount, oneStarCount: $oneStarCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRatingStatsEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.fiveStarCount, fiveStarCount) ||
                other.fiveStarCount == fiveStarCount) &&
            (identical(other.fourStarCount, fourStarCount) ||
                other.fourStarCount == fourStarCount) &&
            (identical(other.threeStarCount, threeStarCount) ||
                other.threeStarCount == threeStarCount) &&
            (identical(other.twoStarCount, twoStarCount) ||
                other.twoStarCount == twoStarCount) &&
            (identical(other.oneStarCount, oneStarCount) ||
                other.oneStarCount == oneStarCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      averageRating,
      totalRatings,
      fiveStarCount,
      fourStarCount,
      threeStarCount,
      twoStarCount,
      oneStarCount);

  /// Create a copy of UserRatingStatsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRatingStatsEntityImplCopyWith<_$UserRatingStatsEntityImpl>
      get copyWith => __$$UserRatingStatsEntityImplCopyWithImpl<
          _$UserRatingStatsEntityImpl>(this, _$identity);
}

abstract class _UserRatingStatsEntity implements UserRatingStatsEntity {
  const factory _UserRatingStatsEntity(
      {required final String userId,
      final double averageRating,
      final int totalRatings,
      final int fiveStarCount,
      final int fourStarCount,
      final int threeStarCount,
      final int twoStarCount,
      final int oneStarCount}) = _$UserRatingStatsEntityImpl;

  @override
  String get userId;
  @override
  double get averageRating;
  @override
  int get totalRatings;
  @override
  int get fiveStarCount;
  @override
  int get fourStarCount;
  @override
  int get threeStarCount;
  @override
  int get twoStarCount;
  @override
  int get oneStarCount;

  /// Create a copy of UserRatingStatsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRatingStatsEntityImplCopyWith<_$UserRatingStatsEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
