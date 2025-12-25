// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      phoneNumber: json['phone'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      isVerified: json['is_verified'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      lastLogin: json['last_login'] == null
          ? null
          : DateTime.parse(json['last_login'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phoneNumber,
      'role': instance.role,
      'email': instance.email,
      'name': instance.name,
      'profile_picture': instance.profilePicture,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'is_verified': instance.isVerified,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_login': instance.lastLogin?.toIso8601String(),
    };
