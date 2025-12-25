import 'package:intl/intl.dart';
import 'dart:math' as math;

class Helpers {
  // Format Currency (INR)
  static String formatCurrency(double amount, {bool showSymbol = true}) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: showSymbol ? '₹' : '',
      decimalDigits: amount % 1 == 0 ? 0 : 2,
    );
    return formatter.format(amount);
  }

  // Format Date
  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  // Format Time
  static String formatTime(DateTime time, {bool use24Hour = false}) {
    return DateFormat(use24Hour ? 'HH:mm' : 'hh:mm a').format(time);
  }

  // Format DateTime
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  // Get Relative Time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  // Calculate Distance between two coordinates (Haversine formula)
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // km

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final distance = earthRadius * c;

    return double.parse(distance.toStringAsFixed(2));
  }

  static double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  // Format Distance
  static String formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      return '${(distanceInKm * 1000).round()} m';
    } else {
      return '${distanceInKm.toStringAsFixed(1)} km';
    }
  }

  // Calculate Duration between two DateTimes
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'}${minutes > 0 ? ' $minutes min' : ''}';
    } else {
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    }
  }

  // Calculate Booking Duration
  static Duration calculateBookingDuration(DateTime start, DateTime end) {
    return end.difference(start);
  }

  // Calculate Total Cost
  static double calculateTotalCost({
    required double pricePerHour,
    required Duration duration,
  }) {
    final hours = duration.inMinutes / 60;
    return pricePerHour * hours;
  }

  // Calculate Platform Commission
  static double calculateCommission(double amount, double commissionRate) {
    return amount * commissionRate;
  }

  // Calculate Owner Earnings (after commission)
  static double calculateOwnerEarnings(double totalAmount, double commissionRate) {
    return totalAmount - calculateCommission(totalAmount, commissionRate);
  }

  // Format Phone Number (Indian format)
  static String formatPhoneNumber(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

    if (cleaned.startsWith('+91')) {
      final number = cleaned.substring(3);
      return '+91 ${number.substring(0, 5)} ${number.substring(5)}';
    } else if (cleaned.length == 10) {
      return '+91 ${cleaned.substring(0, 5)} ${cleaned.substring(5)}';
    }

    return phone;
  }

  // Truncate Text with Ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Get Initials from Name
  static String getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '';

    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
    }
  }

  // Generate Random Color from String (for avatar backgrounds)
  static int getColorFromString(String str) {
    int hash = 0;
    for (int i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }

    final colors = [
      0xFF2196F3, // Blue
      0xFF4CAF50, // Green
      0xFFFF9800, // Orange
      0xFF9C27B0, // Purple
      0xFFE91E63, // Pink
      0xFF00BCD4, // Cyan
      0xFFFF5722, // Deep Orange
      0xFF795548, // Brown
    ];

    return colors[hash.abs() % colors.length];
  }

  // Check if Time is in Future
  static bool isFutureTime(DateTime dateTime) {
    return dateTime.isAfter(DateTime.now());
  }

  // Check if Time is in Past
  static bool isPastTime(DateTime dateTime) {
    return dateTime.isBefore(DateTime.now());
  }

  // Get Time Range String
  static String getTimeRangeString(DateTime start, DateTime end) {
    return '${formatTime(start)} - ${formatTime(end)}';
  }

  // Round to Nearest Slot Interval
  static DateTime roundToNearestSlot(DateTime dateTime, int intervalMinutes) {
    final minutes = dateTime.minute;
    final roundedMinutes = (minutes / intervalMinutes).round() * intervalMinutes;
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      roundedMinutes,
    );
  }

  // Check if two time slots overlap
  static bool doTimeSlotsOverlap(
    DateTime start1,
    DateTime end1,
    DateTime start2,
    DateTime end2,
  ) {
    return start1.isBefore(end2) && start2.isBefore(end1);
  }

  // Capitalize First Letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Format File Size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }
}
