import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showroom_app/screens/main_screen.dart';
import 'package:showroom_app/screens/main_screen_owner.dart';
import 'package:showroom_app/screens/splash_screen.dart';

import 'auth/login.dart';
import 'auth/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? isUser = 2;
  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.clear();
    if (prefs.getInt('isUser') != 2) {
      setState(() {
        isUser = prefs.getInt('isUser');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCheck();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(isUser: isUser),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/main': (context) => const MainScreen(),
        '/main-owner': (context) => const MainScreenOwner(),

      },
      title: 'Flutter Show room',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
       
        // home: SplashScreen(isUser: isUser));
  }
}
