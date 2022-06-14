import '../controllers/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  late splashscreenController cx;
  @override
  Widget build(BuildContext context) {
    cx = Get.find<splashscreenController>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/airsoftmarket.png',
                  fit: BoxFit.cover,
                  width: 220,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Version 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
