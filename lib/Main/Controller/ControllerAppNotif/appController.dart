import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notifikasi/Core/Connection/api_constants.dart';
import 'package:notifikasi/Core/Utils/SharedPreferences.dart';
import 'package:notifikasi/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:notifikasi/models/tiket_model.dart';

class AppListController extends ChangeNotifier {
  BuildContext? context;
  AppListController({this.context});

  bool isConnected = false;
  Position? currentPosition;
  bool isCheckingWifi = false;
  // var isLoading = false;

  String? _platformVersion;
  String get platformVersion => _platformVersion ?? "Unknown Platform Version";

  String? _statusData;
  String get statusData => _statusData ?? "Unknown Platform Version";

  List<Tiket> items = [];
  List<Tiket> filteredItems = [];
  bool isLoading = false;
  String? errorMessage;
  Timer? _timer;

  Future<void> fetchItems() async {
    try {
      isLoading = true;
      notifyListeners();

      String? token = await SharedPreferencesHelper.getToken();
      final response = await ApiConstants.getRequestApp('bpp/list');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> itemsData = data['data'] as List<dynamic>;
        items = itemsData.map((item) => Tiket.fromJson(item)).toList();
        filteredItems = items;
        errorMessage = null;
      } else {
        errorMessage = 'Failed to load items. Error code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Failed to load items: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Initialization Method
  Future<void> initialize(String platformVersion, Function(String) showMessageCallback) async {
    try {
      isConnected = Constants.isConnect;
      currentPosition = await _getCurrentLocation();
      await checkDevice(platformVersion, showMessageCallback);
    } catch (e) {
      showMessageCallback("Error during initialization: $e");
    }
  }

  // Location Method
  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // Device Check Method
   Future<void> checkDevice(String platformVersion, Function(String) showMessageCallback) async {
    String deviceId = platformVersion;

    Map<String, String> body = {
      "ID_DEVICE": deviceId
    };

    try {
      final response = await http.post(
        Uri.parse(Constants.Url + "bpp/cek-wifi"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print("ID perangkat valid: $deviceId");
        _statusData = '200';
        // String dataStats = "NONE";
        deviceId = deviceId;
        // await listTiket(dataStats, showMessageCallback);
      } else {
        print("ID perangkat tidak valid: $deviceId");
        _statusData = response.statusCode.toString();
        deviceId = deviceId;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      _statusData = 'error'; 
      deviceId = deviceId;
    }
  }

  // Fetch Tickets Method
  static Future<List<Tiket>> listTiket(String statusData, Function(String) showMessageCallback) async {
    if (statusData != '200') {
      showMessageCallback("Invalid status, you doesn't have access to this");
      return [];
    }else{
      try {
        final response = await http.get(
          Uri.parse(Constants.Url + "bpp/list"),
          headers: {'Accept': 'application/json',},
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final listData = data['data'] as List;
          if (listData.isEmpty) {
            showMessageCallback('No data need to be approved');
            return [];
          }
          return listData.map((e) => Tiket.fromJson(e)).toList();
        } else {
          showMessageCallback('Failed to load tickets');
          return [];
        }
      } catch (e) {
        showMessageCallback('Error fetching tickets: $e');
        return [];
      }
    }
  }

  static Future<List<Map<String, String>>> handleRejection(String statusData) async {
    try {
      final response = await ApiConstants.getRequest('bpp/list-reject', '');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> listData = data['data'];
        return listData.map<Map<String, String>>((item) => {
          "code": item["code"] as String,
          "longdescription": item["longdescription"] as String,
        }).toList();
      } else {
        throw 'Failed to load rejection data: ${response.body}';
      }
    } catch (e) {
      throw "Error fetching rejection data: $e";
    }
  }
  
  Future<void> saveData(String device, String kodeDipilih, Function(String) showMessageCallback) async {
    try {
      isLoading = true;
      var response = await ApiConstants.postRequest('bpp/cekpin', {
        'ID_DEVICE': device,
        'PIN': kodeDipilih,
      });

      if (response['message'] == "200") {
        showMessageCallback('PIN verified successfully');
      } else {
        showMessageCallback('Failed to verify PIN');
      }
    } catch (e) {
      showMessageCallback('Error saving data: $e');
    } finally {
      isLoading = false;
    }
  }
}