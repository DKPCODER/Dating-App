import 'dart:async';
import 'package:dating_app/authenticationScreen/homescreen.dart';
import 'package:dating_app/authenticationScreen/loginscreen.dart';
import 'package:dating_app/controller/authentication_controller.dart';
import 'package:dating_app/controller/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    bool isLogged = await Helper().getLoginStatus();
    Future.delayed(Duration(seconds: 5), () {
      if (isLogged) {
        Get.offAll(HomeScreen());
      } else {
        Get.offAll(LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png',
                width: 300), // Replace with your image path
            SizedBox(height: 16),
            Text(
              'Dating App',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
