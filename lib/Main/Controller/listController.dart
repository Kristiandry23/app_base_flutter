import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notifikasi/Core/Connection/api_constants.dart';
import 'package:notifikasi/core/data/gerobak.dart';
import 'package:notifikasi/core/utils/SharedPreferences.dart';

class ListController extends ChangeNotifier {
  List<Gerobak> items = [];
  List<Gerobak> filteredItems = [];
  bool isLoading = false;
  String? errorMessage;
  Timer? _timer; // Timer untuk merefresh data otomatis

   ListController() {
    // Mulai timer saat controller diinisialisasi
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 120), (timer) {
      fetchItems();
    });
  }

  Future<void> fetchItems() async {
    try {
      isLoading = true;
      notifyListeners();

      String? token = await SharedPreferencesHelper.getToken();
      final response = await ApiConstants.getRequest('position', token!);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> itemsData = data['data'] as List<dynamic>;
        items = itemsData.map((item) => Gerobak.fromJson(item)).toList();
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

  void updateSearch(String query) {
    if (query.isEmpty) {
      filteredItems = items;
    } else {
      filteredItems = items
          .where((item) =>
              item.kodeAreaDetail.toLowerCase().contains(query.toLowerCase()) ||
              item.noGerobak.toLowerCase().contains(query.toLowerCase()) ||
              item.prodDemand.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}