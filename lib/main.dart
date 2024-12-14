import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/authentication/auth_controller.dart';
import 'features/home/home_page.dart';
import 'core/network/network_service.dart';
import 'core/constants.dart';
import 'features/authentication/login_page.dart';
import 'shared/theme/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        Provider(create: (context) => NetworkService()),
      ],
      child: MaterialApp(
        title: 'Aplikasi Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
