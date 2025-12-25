import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';
import '../models/user_model.dart';

class BookingProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<BookingModel> _userBookings = [];
  List<BookingModel> _providerBookings = [];
  bool _isLoading = false;

  List<BookingModel> get userBookings => _userBookings;
  List<BookingModel> get providerBookings => _providerBookings;
  bool get isLoading => _isLoading;

  Future<bool> createBooking({
    required String userId,
    required String providerId,
    required DateTime startTime,
    required DateTime endTime,
    required double totalAmount,
    required String providerAddress,
    required double providerLatitude,
    required double providerLongitude,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final bookingId = _firestore.collection('bookings').doc().id;
      
      final booking = BookingModel(
        id: bookingId,
        userId: userId,
        providerId: providerId,
        startTime: startTime,
        endTime: endTime,
        totalAmount: totalAmount,
        status: BookingStatus.pending,
        createdAt: DateTime.now(),
        providerAddress: providerAddress,
        providerLatitude: providerLatitude,
        providerLongitude: providerLongitude,
      );

      await _firestore
          .collection('bookings')
          .doc(bookingId)
          .set(booking.toMap());

      // Update provider's time slot to booked
      await _updateProviderTimeSlot(providerId, startTime, endTime, userId);

      return true;
    } catch (e) {
      print('Error creating booking: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _updateProviderTimeSlot(
    String providerId,
    DateTime startTime,
    DateTime endTime,
    String userId,
  ) async {
    final providerDoc = await _firestore.collection('users').doc(providerId).get();
    if (providerDoc.exists) {
      final provider = UserModel.fromMap(providerDoc.data()!);
      if (provider.providerDetails != null) {
        final updatedSlots = provider.providerDetails!.availableSlots.map((slot) {
          if (slot.startTime == startTime && slot.endTime == endTime) {
            return TimeSlot(
              startTime: slot.startTime,
              endTime: slot.endTime,
              isBooked: true,
              bookedBy: userId,
            );
          }
          return slot;
        }).toList();

        await _firestore.collection('users').doc(providerId).update({
          'providerDetails.availableSlots': updatedSlots.map((slot) => slot.toMap()).toList(),
        });
      }
    }
  }

  Future<void> loadUserBookings(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _userBookings = querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error loading user bookings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProviderBookings(String providerId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('bookings')
          .where('providerId', isEqualTo: providerId)
          .orderBy('createdAt', descending: true)
          .get();

      _providerBookings = querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error loading provider bookings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateBookingStatus(String bookingId, BookingStatus status) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).update({
        'status': status.toString().split('.').last,
      });
      return true;
    } catch (e) {
      print('Error updating booking status: $e');
      return false;
    }
  }
}