enum BookingStatus { pending, confirmed, active, completed, cancelled }

class BookingModel {
  final String id;
  final String userId;
  final String providerId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalAmount;
  final BookingStatus status;
  final DateTime createdAt;
  final String providerAddress;
  final double providerLatitude;
  final double providerLongitude;

  BookingModel({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.startTime,
    required this.endTime,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.providerAddress,
    required this.providerLatitude,
    required this.providerLongitude,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      providerId: map['providerId'] ?? '',
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : DateTime.now(),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : DateTime.now(),
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      status: BookingStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
        orElse: () => BookingStatus.pending,
      ),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : DateTime.now(),
      providerAddress: map['providerAddress'] ?? '',
      providerLatitude: map['providerLatitude']?.toDouble() ?? 0.0,
      providerLongitude: map['providerLongitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'providerId': providerId,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'totalAmount': totalAmount,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'providerAddress': providerAddress,
      'providerLatitude': providerLatitude,
      'providerLongitude': providerLongitude,
    };
  }
}