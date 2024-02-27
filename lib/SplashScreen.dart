import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hellogram/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splash: SizedBox(height: 200, child: Image.asset("asset/hello.png")),
          nextScreen: LoginScreen(),
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
