import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';

part 'kyc_entity.freezed.dart';

@freezed
class KYCEntity with _$KYCEntity {
  const factory KYCEntity({
    required String id,
    required String userId,
    required KYCStatus status,
    @Default([]) List<KYCDocument> documents,
    String? rejectionReason,
    DateTime? submittedAt,
    DateTime? reviewedAt,
  }) = _KYCEntity;
}

@freezed
class KYCDocument with _$KYCDocument {
  const factory KYCDocument({
    required String id,
    required DocumentType type,
    required String documentUrl,
    String? documentNumber, // Aadhaar number, PAN number, etc.
    @Default(false) bool isVerified,
    DateTime? uploadedAt,
  }) = _KYCDocument;
}

extension KYCEntityExtension on KYCEntity {
  bool get isApproved => status == KYCStatus.approved;

  bool get isPending => status == KYCStatus.pending;

  bool get isRejected => status == KYCStatus.rejected;

  bool get canSubmit =>
      status == KYCStatus.notSubmitted ||
      status == KYCStatus.rejected ||
      status == KYCStatus.resubmit;

  bool get hasAllRequiredDocuments {
    final hasId = documents.any((doc) =>
        doc.type == DocumentType.aadhaar ||
        doc.type == DocumentType.pan ||
        doc.type == DocumentType.driverLicense ||
        doc.type == DocumentType.passport);

    final hasProperty = documents.any((doc) =>
        doc.type == DocumentType.electricityBill ||
        doc.type == DocumentType.propertyTax ||
        doc.type == DocumentType.rentalAgreement ||
        doc.type == DocumentType.ownershipDeed);

    return hasId && hasProperty;
  }
}
