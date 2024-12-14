import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/network_service.dart';
import '../../core/constants.dart';

class AuthService {
  final NetworkService _networkService = NetworkService();

  // Fungsi untuk melakukan login
  Future<void> login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };

    final response = await _networkService.postData(Constants.loginEndpoint, data);
    if (response['status'] == 'success') {
      // Simpan token atau informasi penting lainnya
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', response['token']);
    } else {
      throw Exception('Login failed');
    }
  }
}