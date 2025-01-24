import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notifikasi/Core/Connection/api_constants.dart';
import 'package:notifikasi/core/utils/SharedPreferences.dart';
import 'package:notifikasi/models/itSupp_model.dart';

class ItSuppListController extends ChangeNotifier {
  List<itSuppModel> items = [];
  List<itSuppModel> filteredItems = [];
  bool isLoading = false;
  String? errorMessage;
  Timer? _timer;

  Future<void> fetchItems() async {
    try {
      isLoading = true;
      notifyListeners();

      String? token = await SharedPreferencesHelper.getToken();
      final response = await ApiConstants.getRequestApp('ticket/it-support');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> itemsData = data['data'] as List<dynamic>;
        items = itemsData.map((item) => itSuppModel.fromJson(item)).toList();
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
}