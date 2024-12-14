import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String _profileData = "Profile data will be here";

  String get profileData => _profileData;

  // Fungsi untuk memperbarui data profil
  void updateProfile(String newProfileData) {
    _profileData = newProfileData;
    notifyListeners();
  }
}