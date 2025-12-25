// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      providerId: json['providerId'] as String,
      providerName: json['providerName'] as String,
      providerLocation:
          Location.fromJson(json['providerLocation'] as Map<String, dynamic>),
      portType: json['portType'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String,
      cancellationReason: json['cancellationReason'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'providerLocation': instance.providerLocation,
      'portType': instance.portType,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'pricePerHour': instance.pricePerHour,
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'cancellationReason': instance.cancellationReason,
      'createdAt': instance.createdAt?.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
    };
