import 'package:airsoftmarket/app/modules/profile/controllers/profile_controller.dart';
import 'package:airsoftmarket/app/utils/color.dart';
import 'package:airsoftmarket/app/widget/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  late ProfileController cx;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    cx = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(title: Text('PROFILE'), centerTitle: true),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 100,
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                backgroundColor: mainColors,
                backgroundImage: AssetImage("assets/images/avatar.png"),
                radius: 70,
              ), //CircleAvatar
              SizedBox(height: 15),
              Text(
                cx.email.value,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6),
              Text(
                cx.name.value.toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 45),
        child: Center(
          child: Obx(
            () => ButtonWidget(
              icon: cx.isloading.value
                  ? CircularProgressIndicator()
                  : Icon(Icons.logout, color: Colors.white),
              onClick: () {
                cx.isloading.value ? null : cx.logout();
              },
              btnText: "LOGOUT",
            ),
          ),
        ),
      ),
    );
  }
}
