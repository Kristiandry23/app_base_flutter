import 'dart:convert';
import 'package:notifikasi/core/constants.dart';
import 'package:http/http.dart' as http;

class ApiConstants {
  
  static Future<Map<String, dynamic>> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.Url + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future getRequest(String endpoint, String token) async{
    try{
      final response = await http.get(
        Uri.parse(Constants.Url + endpoint),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  static Future getRequestApp(String endpoint) async{
    try{
      final response = await http.get(
        Uri.parse(Constants.Url + endpoint),
        headers: {'Accept': 'application/json',},
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }
}