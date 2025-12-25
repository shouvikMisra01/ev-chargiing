import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String phoneNumber,
    required UserRole role,
    String? email,
    String? name,
    String? profilePicture,
    DateTime? dateOfBirth,
    @Default(false) bool isVerified,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) = _UserEntity;
}
