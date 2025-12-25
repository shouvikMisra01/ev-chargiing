import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  User? _user;
  UserModel? _userModel;
  bool _isLoading = false;

  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      await _loadUserModel();
    } else {
      _userModel = null;
    }
    notifyListeners();
  }

  Future<void> _loadUserModel() async {
    if (_user == null) return;
    
    try {
      final doc = await _firestore.collection('users').doc(_user!.uid).get();
      if (doc.exists) {
        _userModel = UserModel.fromMap(doc.data()!);
      }
    } catch (e) {
      print('Error loading user model: $e');
    }
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('Sign in error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // REPLACE your old registerWithEmail function with this new one.

Future<bool> registerWithEmail({
  required String email,
  required String password,
  required String name,
  required String phoneNumber,
  required UserRole role,
}) async {
  try {
    _isLoading = true;
    notifyListeners();

    // We no longer need to save the return value 'credential' because it's causing the crash.
    // We just need to wait for it to complete.
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // After the user is created, _auth.currentUser will be updated.
    // We get the new user directly from the auth instance.
    User? freshlyCreatedUser = _auth.currentUser;

    if (freshlyCreatedUser != null) {
      final userModel = UserModel(
        id: freshlyCreatedUser.uid, // Use the UID from the currentUser
        email: email,
        phoneNumber: phoneNumber,
        name: name,
        role: role,
        createdAt: DateTime.now(),
      );

      // Now create the document in Firestore.
      await _firestore
          .collection('users')
          .doc(freshlyCreatedUser.uid)
          .set(userModel.toMap());

      // The _onAuthStateChanged listener will automatically call _loadUserModel,
      // which will load the user data into the _userModel variable.
      // So we don't need to set it here.
      
      // We manually set the loading state back to false and notify listeners.
      _isLoading = false;
      notifyListeners();
      return true;
    }

    // If for some reason currentUser is null, we fail gracefully.
    _isLoading = false;
    notifyListeners();
    return false;
    
  } catch (e) {
    // This will now only catch legitimate errors, like 'email-already-in-use'.
    print('Registration error: $e');
    _isLoading = false;
    notifyListeners();
    return false;
  }
}

  Future<void> signOut() async {
    await _auth.signOut();
    _userModel = null;
    notifyListeners();
  }

  Future<bool> updateUserProfile(UserModel updatedUser) async {
    try {
      await _firestore
          .collection('users')
          .doc(updatedUser.id)
          .update(updatedUser.toMap());
      
      _userModel = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }
}