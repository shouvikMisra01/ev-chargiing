import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    @JsonKey(name: 'phone') required String phoneNumber,
    required String role,
    String? email,
    String? name,
    @JsonKey(name: 'profile_picture') String? profilePicture,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_login') DateTime? lastLogin,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Convert to Domain Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      phoneNumber: phoneNumber,
      role: UserRole.fromString(role),
      email: email,
      name: name,
      profilePicture: profilePicture,
      dateOfBirth: dateOfBirth,
      isVerified: isVerified,
      createdAt: createdAt,
      lastLogin: lastLogin,
    );
  }

  // Create from Domain Entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber,
      role: entity.role.value,
      email: entity.email,
      name: entity.name,
      profilePicture: entity.profilePicture,
      dateOfBirth: entity.dateOfBirth,
      isVerified: entity.isVerified,
      createdAt: entity.createdAt,
      lastLogin: entity.lastLogin,
    );
  }
}
