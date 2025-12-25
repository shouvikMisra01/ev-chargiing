import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_entity.freezed.dart';

@freezed
class RatingEntity with _$RatingEntity {
  const factory RatingEntity({
    required String id,
    required String bookingId,
    required String raterId, // Who gave the rating
    required String rateeId, // Who received the rating
    required double rating, // 1-5
    String? review,
    @Default([]) List<String> tags, // e.g., "Clean", "Fast", "Helpful"
    DateTime? createdAt,
  }) = _RatingEntity;
}

@freezed
class UserRatingStatsEntity with _$UserRatingStatsEntity {
  const factory UserRatingStatsEntity({
    required String userId,
    @Default(0.0) double averageRating,
    @Default(0) int totalRatings,
    @Default(0) int fiveStarCount,
    @Default(0) int fourStarCount,
    @Default(0) int threeStarCount,
    @Default(0) int twoStarCount,
    @Default(0) int oneStarCount,
  }) = _UserRatingStatsEntity;
}

extension RatingEntityExtension on RatingEntity {
  bool get isPositive => rating >= 4.0;

  bool get isNegative => rating <= 2.0;
}
