import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Import for json.encode and json.decode

class SharedPreferencesHelper {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userData');
  }

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setString('userId', userData['id']);
    prefs.setString('userAccount', userData['user_account']);
    prefs.setString('role', userData['Role']);
    prefs.setString('dept', userData['Dept']);
    prefs.setString('bagian', userData['Bagian'] ?? '');
  }

  // static Future<Map<String, dynamic>?> getUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? userData = prefs.getString('userData');
  //   return userData != null
  //       ? json.decode(userData)
  //       : null; // Use json.decode here
  // }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
  }

  // Get User Role
  static Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? '';
  }

  // Get User Department (Dept)
  static Future<String> getDept() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('dept') ?? '';
  }

  // Get User Section (Bagian)
  static Future<String> getBagian() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('bagian') ?? '';
  }

}
