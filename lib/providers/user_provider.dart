import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<UserModel> _nearbyProviders = [];
  bool _isLoading = false;
  Position? _currentPosition;

  List<UserModel> get nearbyProviders => _nearbyProviders;
  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition;

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      _currentPosition = await Geolocator.getCurrentPosition();
      notifyListeners();
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> loadNearbyProviders({double radiusInKm = 10.0}) async {
    if (_currentPosition == null) {
      await getCurrentLocation();
    }

    if (_currentPosition == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'owner')
          .where('isVerified', isEqualTo: true)
          .get();

      _nearbyProviders = querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .where((provider) {
            if (provider.providerDetails == null) return false;
            
            final distance = Geolocator.distanceBetween(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              provider.providerDetails!.latitude,
              provider.providerDetails!.longitude,
            );
            
            return distance <= (radiusInKm * 1000); // Convert km to meters
          })
          .where((provider) => provider.providerDetails!.isOnline)
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error loading nearby providers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProviderStatus(String userId, bool isOnline) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'providerDetails.isOnline': isOnline,
      });
      return true;
    } catch (e) {
      print('Error updating provider status: $e');
      return false;
    }
  }

  Future<bool> updateProviderAvailability(String userId, List<TimeSlot> slots) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'providerDetails.availableSlots': slots.map((slot) => slot.toMap()).toList(),
      });
      return true;
    } catch (e) {
      print('Error updating provider availability: $e');
      return false;
    }
  }
}