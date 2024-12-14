import 'package:flutter/material.dart';
import 'auth_service.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fungsi login
  Future<void> login(BuildContext context, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await AuthService().login(email, password);
      
      // Menangani login berhasil (navigasi ke halaman home)
      _isLoading = false;
      notifyListeners();
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      // Menangani login gagal
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}