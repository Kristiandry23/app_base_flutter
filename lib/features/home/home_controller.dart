import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  String _welcomeMessage = "Welcome to the app!";
  
  String get welcomeMessage => _welcomeMessage;
}