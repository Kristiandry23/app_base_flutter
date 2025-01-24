import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifikasi/core/constants/image_strings.dart';
import 'package:notifikasi/core/constants/text_strings.dart';
import 'package:notifikasi/core/utils/SharedPreferences.dart';
import 'package:notifikasi/main.dart';
import 'package:notifikasi/Services/notification_service.dart';
import 'package:notifikasi/shared/widgets/error_pages.dart';
import 'package:notifikasi/shared/widgets/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Services/permission_service.dart';
import '../core/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkInitialMessage();
      await _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    await Constants.loadUrlOnce();
    await Constants.checkConnection();
    await Future.delayed(Duration(seconds: 2));

    if (Constants.isConnect) {
      bool isLoggedIn = await _checkLoginStatus();
  
      if (!Constants.iDebug) {
        bool isUpdateAvailable = await _checkForUpdates();
        if (isUpdateAvailable) {
          _showUpdateDialog();
        } else {
          if(isLoggedIn){
            Navigator.pushReplacementNamed(context, '/home');
          }else{
            Navigator.pushReplacementNamed(context, '/login');
          }
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/error');
    }
  }


  Future<bool> _checkLoginStatus() async {
    String? token = await SharedPreferencesHelper.getToken();
    return token != null;
  }

  Future<void> checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    
    if (initialMessage != null) {
      await showNotification(initialMessage);
    }
  }

  Future<bool> _checkForUpdates() async {
    String currentVersion = ITTITexts.appVersion;
    String appBuild = ITTITexts.appBuildName;

    Map<String, dynamic>? versionInfo = await Constants.fetchLatestVersion(appBuild, currentVersion);

    if (versionInfo != null && versionInfo['update_needed'] == true) {
      String latestVersion = versionInfo['latest_version'];
      if (_isVersionGreaterThan(currentVersion, latestVersion)) {
        return true;
      }
    }
    return false;
  }

  bool _isVersionGreaterThan(String currentVersion, String latestVersion) {
    List<int> currentParts = currentVersion.split('.').map(int.parse).toList();
    List<int> latestParts = latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < currentParts.length; i++) {
      if (i >= latestParts.length || currentParts[i] < latestParts[i]) {
        return true;
      } else if (currentParts[i] > latestParts[i]) {
        return false;
      }
    }
    return false;
  }

  void _showUpdateDialog() async {
    String currentVersion = ITTITexts.appVersion;
    String appBuild = ITTITexts.appBuildName;

    Map<String, dynamic>? versionInfo = await Constants.fetchLatestVersion(appBuild, currentVersion);
    String appLink = versionInfo?['app_link'] ?? '';
    String latestVersion = versionInfo?['latest_version'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pembaruan Tersedia"),
          content: Text("Versi terbaru ($latestVersion) tersedia. Apakah Anda ingin memperbarui aplikasi?"),
          actions: <Widget>[
            TextButton(
              child: Text("Update"),
              onPressed: () {
                _launchURL(appLink);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(ITTIImages.logo),
            SizedBox(height: 18),
            Text(
              'Sedang memuat data...',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
