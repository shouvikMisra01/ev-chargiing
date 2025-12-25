class Validators {
  // Phone Number Validation (Indian format)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces and special characters
    final cleaned = value.replaceAll(RegExp(r'[^\d+]'), '');

    // Check for valid Indian phone number
    if (!RegExp(r'^(\+91)?[6-9]\d{9}$').hasMatch(cleaned)) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }

  // OTP Validation
  static String? validateOtp(String? value, {int length = 6}) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }

    if (value.length != length) {
      return 'OTP must be $length digits';
    }

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'OTP must contain only numbers';
    }

    return null;
  }

  // Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // Name Validation
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    if (value.length > 50) {
      return '$fieldName must not exceed 50 characters';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName can only contain letters and spaces';
    }

    return null;
  }

  // Address Validation
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }

    if (value.length < 10) {
      return 'Address must be at least 10 characters';
    }

    if (value.length > 200) {
      return 'Address must not exceed 200 characters';
    }

    return null;
  }

  // Price Validation
  static String? validatePrice(String? value, {double? min, double? max}) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }

    final price = double.tryParse(value);

    if (price == null) {
      return 'Enter a valid price';
    }

    if (min != null && price < min) {
      return 'Price must be at least ₹$min';
    }

    if (max != null && price > max) {
      return 'Price must not exceed ₹$max';
    }

    return null;
  }

  // Required Field Validation
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Aadhaar Number Validation
  static String? validateAadhaar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhaar number is required';
    }

    final cleaned = value.replaceAll(RegExp(r'\s'), '');

    if (!RegExp(r'^\d{12}$').hasMatch(cleaned)) {
      return 'Aadhaar must be a 12-digit number';
    }

    return null;
  }

  // PAN Card Validation
  static String? validatePan(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN number is required';
    }

    final pan = value.toUpperCase();

    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(pan)) {
      return 'Enter a valid PAN number (e.g., ABCDE1234F)';
    }

    return null;
  }

  // Minimum Length Validation
  static String? validateMinLength(String? value, int minLength, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  // Range Validation
  static String? validateRange(String? value, double min, double max, {String fieldName = 'Value'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    final number = double.tryParse(value);

    if (number == null) {
      return 'Enter a valid number';
    }

    if (number < min || number > max) {
      return '$fieldName must be between $min and $max';
    }

    return null;
  }

  // Date of Birth Validation
  static String? validateDateOfBirth(DateTime? value, {int? minAge}) {
    if (value == null) {
      return 'Date of birth is required';
    }

    final now = DateTime.now();

    // Check if date is in the future
    if (value.isAfter(now)) {
      return 'Date of birth cannot be in the future';
    }

    // Check if date is too far in the past (max 120 years)
    final maxAge = now.subtract(const Duration(days: 365 * 120));
    if (value.isBefore(maxAge)) {
      return 'Please enter a valid date of birth';
    }

    // Check minimum age if provided
    if (minAge != null) {
      final age = _calculateAge(value);
      if (age < minAge) {
        return 'You must be at least $minAge years old';
      }
    }

    return null;
  }

  // Age Calculation Helper
  static int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    // Adjust age if birthday hasn't occurred this year
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  // Get Age from Date of Birth
  static int? getAge(DateTime? dateOfBirth) {
    if (dateOfBirth == null) return null;
    return _calculateAge(dateOfBirth);
  }
}
