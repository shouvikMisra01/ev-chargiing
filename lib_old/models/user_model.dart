enum UserRole { user, owner }

class UserModel {
  final String id;
  final String email;
  final String phoneNumber;
  final String name;
  final UserRole role;
  final bool isVerified;
  final DateTime createdAt;
  final ProviderDetails? providerDetails;

  UserModel({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.role,
    this.isVerified = false,
    required this.createdAt,
    this.providerDetails,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == map['role'],
        orElse: () => UserRole.user,
      ),
      isVerified: map['isVerified'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : DateTime.now(),
      providerDetails: map['providerDetails'] != null
          ? ProviderDetails.fromMap(map['providerDetails'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'name': name,
      'role': role.toString().split('.').last,
      'isVerified': isVerified,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'providerDetails': providerDetails?.toMap(),
    };
  }
}

class ProviderDetails {
  final String address;
  final double latitude;
  final double longitude;
  final List<String> equipmentImages;
  final List<String> parkingImages;
  final String chargingPortType;
  final double pricePerHour;
  final bool isOnline;
  final List<TimeSlot> availableSlots;

  ProviderDetails({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.equipmentImages,
    required this.parkingImages,
    required this.chargingPortType,
    required this.pricePerHour,
    this.isOnline = false,
    this.availableSlots = const [],
  });

  factory ProviderDetails.fromMap(Map<String, dynamic> map) {
    return ProviderDetails(
      address: map['address'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      equipmentImages: List<String>.from(map['equipmentImages'] ?? []),
      parkingImages: List<String>.from(map['parkingImages'] ?? []),
      chargingPortType: map['chargingPortType'] ?? '',
      pricePerHour: map['pricePerHour']?.toDouble() ?? 0.0,
      isOnline: map['isOnline'] ?? false,
      availableSlots: (map['availableSlots'] as List<dynamic>?)
              ?.map((slot) => TimeSlot.fromMap(slot as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'equipmentImages': equipmentImages,
      'parkingImages': parkingImages,
      'chargingPortType': chargingPortType,
      'pricePerHour': pricePerHour,
      'isOnline': isOnline,
      'availableSlots': availableSlots.map((slot) => slot.toMap()).toList(),
    };
  }
}

class TimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;
  final String? bookedBy;

  TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isBooked = false,
    this.bookedBy,
  });

  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : DateTime.now(),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : DateTime.now(),
      isBooked: map['isBooked'] ?? false,
      bookedBy: map['bookedBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'isBooked': isBooked,
      'bookedBy': bookedBy,
    };
  }
}