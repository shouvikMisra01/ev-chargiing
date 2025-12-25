import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/app_router.dart';

// Placeholder for image picker - would need image_picker package
// import 'package:image_picker/image_picker.dart';

enum KycDocumentType {
  aadhaar,
  pan,
  driverLicense,
  passport,
}

extension KycDocumentTypeExtension on KycDocumentType {
  String get displayName {
    switch (this) {
      case KycDocumentType.aadhaar:
        return 'Aadhaar Card';
      case KycDocumentType.pan:
        return 'PAN Card';
      case KycDocumentType.driverLicense:
        return 'Driver License';
      case KycDocumentType.passport:
        return 'Passport';
    }
  }

  String get description {
    switch (this) {
      case KycDocumentType.aadhaar:
        return 'Upload front and back of your Aadhaar card';
      case KycDocumentType.pan:
        return 'Upload your PAN card';
      case KycDocumentType.driverLicense:
        return 'Upload front and back of your driver license';
      case KycDocumentType.passport:
        return 'Upload your passport photo page';
    }
  }

  IconData get icon {
    switch (this) {
      case KycDocumentType.aadhaar:
        return Icons.credit_card;
      case KycDocumentType.pan:
        return Icons.account_balance;
      case KycDocumentType.driverLicense:
        return Icons.directions_car;
      case KycDocumentType.passport:
        return Icons.flight;
    }
  }
}

enum PropertyProofType {
  electricityBill,
  propertyTax,
  rentalAgreement,
  ownershipDeed,
}

extension PropertyProofTypeExtension on PropertyProofType {
  String get displayName {
    switch (this) {
      case PropertyProofType.electricityBill:
        return 'Electricity Bill';
      case PropertyProofType.propertyTax:
        return 'Property Tax Receipt';
      case PropertyProofType.rentalAgreement:
        return 'Rental Agreement';
      case PropertyProofType.ownershipDeed:
        return 'Ownership Deed';
    }
  }
}

class KycUploadScreen extends ConsumerStatefulWidget {
  const KycUploadScreen({super.key});

  @override
  ConsumerState<KycUploadScreen> createState() => _KycUploadScreenState();
}

class _KycUploadScreenState extends ConsumerState<KycUploadScreen> {
  KycDocumentType _selectedIdType = KycDocumentType.aadhaar;
  PropertyProofType _selectedPropertyType = PropertyProofType.electricityBill;

  // Uploaded documents (paths)
  String? _idDocumentFront;
  String? _idDocumentBack;
  String? _propertyProof;
  String? _stationPhoto;

  bool _isSubmitting = false;

  // Placeholder for image picker
  Future<void> _pickImage(String documentType) async {
    // TODO: Implement image picker
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.camera);
    // or source: ImageSource.gallery

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Image picker for $documentType (requires image_picker package)'),
        backgroundColor: AppColors.primary,
      ),
    );

    // Mock: Simulate image picked
    setState(() {
      switch (documentType) {
        case 'id_front':
          _idDocumentFront = '/mock/path/id_front.jpg';
          break;
        case 'id_back':
          _idDocumentBack = '/mock/path/id_back.jpg';
          break;
        case 'property':
          _propertyProof = '/mock/path/property.jpg';
          break;
        case 'station':
          _stationPhoto = '/mock/path/station.jpg';
          break;
      }
    });
  }

  bool _isFormValid() {
    return _idDocumentFront != null &&
        (_selectedIdType == KycDocumentType.pan || _idDocumentBack != null) &&
        _propertyProof != null &&
        _stationPhoto != null;
  }

  Future<void> _submitKyc() async {
    if (!_isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload all required documents'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // TODO: Upload documents to backend
      // final formData = FormData.fromMap({
      //   'id_type': _selectedIdType.name,
      //   'id_document_front': await MultipartFile.fromFile(_idDocumentFront!),
      //   'id_document_back': _idDocumentBack != null
      //       ? await MultipartFile.fromFile(_idDocumentBack!)
      //       : null,
      //   'property_proof_type': _selectedPropertyType.name,
      //   'property_proof': await MultipartFile.fromFile(_propertyProof!),
      //   'station_photo': await MultipartFile.fromFile(_stationPhoto!),
      // });
      //
      // await dio.post('/owner/kyc/upload', data: formData);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Show success dialog
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 32),
              SizedBox(width: 12),
              Text('KYC Submitted!'),
            ],
          ),
          content: const Text(
            'Your documents have been submitted successfully. '
            'Our team will review them within 24-48 hours and update your verification status.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.ownerHome);
              },
              child: const Text('Got it'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('KYC Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Complete KYC to start accepting bookings and earning',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Identity Document Section
            Text('Identity Proof', style: AppTextStyles.h3),
            const SizedBox(height: 16),

            // ID Type Dropdown
            DropdownButtonFormField<KycDocumentType>(
              value: _selectedIdType,
              decoration: const InputDecoration(
                labelText: 'Document Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              items: KycDocumentType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Icon(type.icon, size: 20),
                      const SizedBox(width: 12),
                      Text(type.displayName),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedIdType = value;
                    // Reset back image if switching to PAN (single-sided)
                    if (value == KycDocumentType.pan) {
                      _idDocumentBack = null;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 12),

            Text(
              _selectedIdType.description,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),

            // ID Document Upload
            Row(
              children: [
                Expanded(
                  child: _buildUploadBox(
                    label: 'Front Side',
                    imagePath: _idDocumentFront,
                    onTap: () => _pickImage('id_front'),
                  ),
                ),
                if (_selectedIdType != KycDocumentType.pan) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildUploadBox(
                      label: 'Back Side',
                      imagePath: _idDocumentBack,
                      onTap: () => _pickImage('id_back'),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 32),

            // Property Proof Section
            Text('Property Proof', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            Text(
              'Proof of ownership or rental agreement for the charging station location',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<PropertyProofType>(
              value: _selectedPropertyType,
              decoration: const InputDecoration(
                labelText: 'Document Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
              items: PropertyProofType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedPropertyType = value);
                }
              },
            ),
            const SizedBox(height: 16),

            _buildUploadBox(
              label: 'Upload Document',
              imagePath: _propertyProof,
              onTap: () => _pickImage('property'),
              fullWidth: true,
            ),
            const SizedBox(height: 32),

            // Station Photo Section
            Text('Charging Station Photo', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            Text(
              'Upload a clear photo of your charging station',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),

            _buildUploadBox(
              label: 'Station Photo',
              imagePath: _stationPhoto,
              onTap: () => _pickImage('station'),
              fullWidth: true,
            ),
            const SizedBox(height: 32),

            // Guidelines
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.tips_and_updates, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Upload Guidelines',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildGuideline('Clear, readable images (not blurry)'),
                  _buildGuideline('All corners of the document visible'),
                  _buildGuideline('No glare or shadows'),
                  _buildGuideline('Original documents (not photocopies)'),
                  _buildGuideline('File size < 10 MB'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : (_isFormValid() ? _submitKyc : null),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Submit for Verification'),
              ),
            ),
            const SizedBox(height: 16),

            // Privacy Notice
            Text(
              'Your documents are encrypted and securely stored. We use them only for verification purposes.',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox({
    required String label,
    required String? imagePath,
    required VoidCallback onTap,
    bool fullWidth = false,
  }) {
    final hasImage = imagePath != null;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: fullWidth ? 180 : 150,
        decoration: BoxDecoration(
          color: hasImage ? AppColors.success.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasImage ? AppColors.success : AppColors.border,
            width: hasImage ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasImage ? Icons.check_circle : Icons.cloud_upload,
              size: 48,
              color: hasImage ? AppColors.success : AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              hasImage ? 'Uploaded ✓' : label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: hasImage ? AppColors.success : AppColors.textSecondary,
                fontWeight: hasImage ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (!hasImage) ...[
              const SizedBox(height: 4),
              Text(
                'Tap to upload',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
            ],
            if (hasImage) ...[
              const SizedBox(height: 4),
              Text(
                'Tap to change',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGuideline(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 16, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.caption.copyWith(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
