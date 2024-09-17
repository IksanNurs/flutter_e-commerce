import 'package:flutter/material.dart';
import 'package:showroom_app/auth/login.dart';
import 'package:showroom_app/screens/home_screen.dart';
import 'package:showroom_app/screens/main_screen.dart';
import 'package:showroom_app/screens/main_screen_owner.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.isUser});
  final int? isUser;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context,
          widget.isUser == 0 ? '/main' : widget.isUser == 1 ? '/main-owner' : '/login'
          // MaterialPageRoute(
          //     builder: (c) => widget.isUser == 0
          //         ? MainScreen()
          //         : widget.isUser == 1
          //             ? MainScreenOwner()
          //             : Login())
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo_splash.png'),
      ),
    );
  }
}
