// User Roles
enum UserRole {
  user('user', 'EV User'),
  owner('owner', 'Residential Owner');

  final String value;
  final String display;

  const UserRole(this.value, this.display);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.user,
    );
  }
}

// Booking Status
enum BookingStatus {
  pending('pending', 'Pending'),
  confirmed('confirmed', 'Confirmed'),
  active('active', 'Active'),
  completed('completed', 'Completed'),
  cancelled('cancelled', 'Cancelled'),
  rejected('rejected', 'Rejected');

  final String value;
  final String display;

  const BookingStatus(this.value, this.display);

  static BookingStatus fromString(String value) {
    return BookingStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => BookingStatus.pending,
    );
  }
}

// Charging Session Status
enum ChargingStatus {
  notStarted('not_started', 'Not Started'),
  active('active', 'Active'),
  paused('paused', 'Paused'),
  completed('completed', 'Completed'),
  cancelled('cancelled', 'Cancelled');

  final String value;
  final String display;

  const ChargingStatus(this.value, this.display);

  static ChargingStatus fromString(String value) {
    return ChargingStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => ChargingStatus.notStarted,
    );
  }
}

// KYC Status
enum KYCStatus {
  notSubmitted('not_submitted', 'Not Submitted'),
  pending('pending', 'Pending Review'),
  approved('approved', 'Approved'),
  rejected('rejected', 'Rejected'),
  resubmit('resubmit', 'Resubmit Required');

  final String value;
  final String display;

  const KYCStatus(this.value, this.display);

  static KYCStatus fromString(String value) {
    return KYCStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => KYCStatus.notSubmitted,
    );
  }
}

// Payment Method
enum PaymentMethod {
  wallet('wallet', 'Wallet'),
  upi('upi', 'UPI'),
  card('card', 'Credit/Debit Card'),
  netbanking('netbanking', 'Net Banking');

  final String value;
  final String display;

  const PaymentMethod(this.value, this.display);

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (method) => method.value == value,
      orElse: () => PaymentMethod.wallet,
    );
  }
}

// Payment Status
enum PaymentStatus {
  pending('pending', 'Pending'),
  processing('processing', 'Processing'),
  success('success', 'Success'),
  failed('failed', 'Failed'),
  refunded('refunded', 'Refunded');

  final String value;
  final String display;

  const PaymentStatus(this.value, this.display);

  static PaymentStatus fromString(String value) {
    return PaymentStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => PaymentStatus.pending,
    );
  }
}

// Charging Port Type
enum ChargingPortType {
  type1('type1', 'Type 1'),
  type2('type2', 'Type 2'),
  ccs('ccs', 'CCS'),
  chademo('chademo', 'CHAdeMO'),
  gbt('gbt', 'GB/T');

  final String value;
  final String display;

  const ChargingPortType(this.value, this.display);

  static ChargingPortType fromString(String value) {
    return ChargingPortType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => ChargingPortType.type2,
    );
  }
}

// Document Type (for KYC)
enum DocumentType {
  aadhaar('aadhaar', 'Aadhaar Card'),
  pan('pan', 'PAN Card'),
  driverLicense('driver_license', 'Driver License'),
  passport('passport', 'Passport'),
  electricityBill('electricity_bill', 'Electricity Bill'),
  propertyTax('property_tax', 'Property Tax Receipt'),
  rentalAgreement('rental_agreement', 'Rental Agreement'),
  ownershipDeed('ownership_deed', 'Ownership Deed');

  final String value;
  final String display;

  const DocumentType(this.value, this.display);

  static DocumentType fromString(String value) {
    return DocumentType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => DocumentType.aadhaar,
    );
  }
}

// Transaction Type
enum TransactionType {
  credit('credit', 'Credit'),
  debit('debit', 'Debit');

  final String value;
  final String display;

  const TransactionType(this.value, this.display);

  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => TransactionType.debit,
    );
  }
}
