// import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/network_service.dart';
import '../../core/network/api_constants.dart';

class HomeService {
  final NetworkService _networkService = NetworkService();

  // Mengambil data pengguna dari API
  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await _networkService.getData(ApiConstants.userProfileUrl);
    return response;
  }
}