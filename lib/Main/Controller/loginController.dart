import 'package:notifikasi/Core/Connection/api_constants.dart';
import 'package:notifikasi/Core/Utils/SharedPreferences.dart';
import 'package:notifikasi/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  static bool isLogin = false;

  
  static loginSession(String username, String password) async {
    await Constants.checkConnection();
    
    if(!Constants.isConnect){
      return isLogin;
    }else{
      final response = await ApiConstants.postRequest('auth/loginMobile',{
        'username': username,
        'password': password,
      });

      if (!response['status']){
        isLogin = false;
      }else{
        print('Password: $password');
        await SharedPreferencesHelper.saveToken(response['token']);
        await SharedPreferencesHelper.saveUserData(response['data']);
        isLogin = true;
      }
    }
  }

}
