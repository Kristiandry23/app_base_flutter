// import 'dart:convert';

// import 'package:cart_loc/core/constants.dart';
// import 'package:cart_loc/core/external/sharedPreferance/SharedPreferences.dart';
// import 'package:cart_loc/core/network/services.dart';
// import 'package:flutter/material.dart';

// class scanController extends ChangeNotifier {
//   static bool isAny = false;

//   static getAreaCode(String barcode) async {
//     await Constants.checkConnection();
    
//     String? token = await SharedPreferencesHelper.getToken();
//     final response = await ApiConstants.getArea('check/location', token!, barcode);
//     final data = json.decode(response.body) as Map<String, dynamic>;

//     if (!data['status']){
//       isAny = false;
//       return isAny;
//     }else{
//       isAny = true;
//       return isAny;
//     }
//   }

//   static getCartCode(String barcode) async {
//     await Constants.checkConnection();
    
//     String? token = await SharedPreferencesHelper.getToken();
//     final response = await ApiConstants.getCart('check/gerobak-number', token!, barcode);
//     final data = json.decode(response.body) as Map<String, dynamic>;

//     if (!data['status']){
//       isAny = false;
//       return isAny;
//     }else{
//       isAny = true;
//       return isAny;
//     }
//   }

//   static getProdCode(String barcode) async {
//     await Constants.checkConnection();
    
//     String? token = await SharedPreferencesHelper.getToken();
//     final response = await ApiConstants.getCart('check/gerobak-card', token!, barcode);
//     final data = json.decode(response.body) as Map<String, dynamic>;

//     if (!data['status']){
//       isAny = false;
//       return isAny;
//     }else{
//       isAny = true;
//       return isAny;
//     }
//   }
// }