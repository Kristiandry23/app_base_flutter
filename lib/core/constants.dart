import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:notifikasi/Core/Connection/connection.dart';

class Constants {
  static String Url = '';
  static bool isConnect = false;
  static bool _isUrlLoaded = false;
  static bool iDebug = false;
  static late NetworkInfo _networkInfo = NetworkInfo();

  static Future<void> loadUrlOnce() async {
    if (!_isUrlLoaded) {
      Url = await getUrl();
      _isUrlLoaded = true;
    }
  }

  static Future<String> getUrl() async {
    try {
      if (iDebug) {
        return Conn.baseLocalUrl;
      } else {
        return Conn.baseUrl;
      }
    } catch (e) {
      print('Error saat memeriksa nama Wi-Fi: $e');
      return '';
    }
  }

  static Future<bool> _getWifiName() async {
    try {
      String? wifiName = await _networkInfo.getWifiName();
      wifiName = wifiName?.replaceAll('"', '').trim();

      if (wifiName == null || wifiName != 'ITTI_Wifi') {
        print('Nama Wi-Fi: $wifiName');
        return false;
      } else {
        print('Terhubung ke: $wifiName');
        return true;
      }
    } catch (e) {
      print('Error saat memeriksa nama Wi-Fi: $e');
      return false;
    }
  }

  static Future<bool> _hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }

      final response = await http.get(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error saat memeriksa koneksi internet: $e');
      return false;
    }
  }

  // static Future<bool> _canAccessApi() async {
  //   try {
  //     final baseUrl = Uri.parse(Url).origin;
  //     final response = await http.get(Uri.parse(baseUrl));

  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print('Error saat memeriksa akses API: $e');
  //     return false;
  //   }
  // }

  static Future<bool> checkConnection() async {
    try {
      // Langkah 1: Periksa koneksi internet
      bool internetConnection = await _hasInternetConnection();
      if (!internetConnection) {
        print("Gagal: Tidak ada koneksi internet");
        isConnect = false;
        return isConnect;
      }

      // Langkah 2: Periksa aksesibilitas API
      // bool canAccessApi = await _canAccessApi();
      // if (!canAccessApi) {
      //   print("Gagal: API tidak dapat diakses");
      //   isConnect = false;
      //   return isConnect;
      // }

      // Langkah 3: Periksa nama Wi-Fi
      // bool isWifiCorrect = await _getWifiName();
      // if (!isWifiCorrect) {
      //   print("Gagal: Nama Wi-Fi tidak sesuai");
      //   isConnect = false;
      //   return isConnect;
      // }
      isConnect = true;
      return isConnect;
    } catch (e) {
      print("Kesalahan tidak terduga: $e");
      isConnect = false;
      return isConnect;
    }
  }

  static Future<Map<String, dynamic>?> fetchLatestVersion(String appName, String currentVersion) async {
    final String versionCheckUrl = '${Conn.baseCartUrl}check_version?app_name=$appName&app_ver=$currentVersion';

    try {
      final response = await http.get(Uri.parse(versionCheckUrl));
      var data = response;
      if (response.statusCode == 200) {
        final data = response.body;
        final Map<String, dynamic> jsonData = jsonDecode(data);

        if (jsonData.containsKey('update_needed') && jsonData.containsKey('app_link')) {
          return {
            'update_needed': jsonData['update_needed'],
            'app_link': jsonData['app_link'],
            'latest_version': jsonData['latest_version'],
          };
        } else {
          return {
            'update_needed': false,
            'app_link': '',
            'latest_version': currentVersion,
          };
        }
      } else {
        throw Exception('Failed to fetch version data');
      }
    } catch (e) {
      return null;
    }
  }
}
