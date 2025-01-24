/// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notifikasi/Core/constants.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/appController.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/erpController.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/itSuppController.dart';
import 'package:notifikasi/Main/Controller/listController.dart';
import 'package:notifikasi/Main/Controller/ControllerAppNotif/mtcController.dart';
import 'package:notifikasi/Main/Pages/ModulAppNotif/ApprovalPages/approval.dart';
import 'package:notifikasi/Main/Pages/ModulUniversal/login.dart';
import 'package:notifikasi/Widgets/splash_screen_handler.dart';
import 'package:provider/provider.dart';
import 'package:notifikasi/Main/Pages/ModulUniversal/home.dart';
import 'package:notifikasi/Shared/widgets/error_pages.dart';
import 'Services/firebase_service.dart';
import 'Services/notification_service.dart';
import 'Services/permission_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  // await Constants.loadUrlOnce();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  setupFirebaseListeners();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppListController()..fetchItems()),
        ChangeNotifierProvider(create: (_) => MtcListController()..fetchItems()),
        ChangeNotifierProvider(create: (_) => ErpListController()..fetchItems()),
        ChangeNotifierProvider(create: (_) => ItSuppListController()..fetchItems()),
      ],
      child: MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/error': (context) => ErrorPages(),
        '/approve': (context) => ApprovalPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
