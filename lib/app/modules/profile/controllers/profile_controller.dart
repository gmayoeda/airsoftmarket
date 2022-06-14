import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:airsoftmarket/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  RxString name = "".obs, email = "".obs;
  var isloading = false.obs;
  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      name.value = users['name'];
      email.value = users['email'];
    } else {
      print('no getbox!');
    }
  }

  void logout() {
    isloading.value = true;
    Get.defaultDialog(
        title: "Logout",
        textCancel: "Kembali",
        textConfirm: "Logout",
        confirmTextColor: Colors.white,
        onConfirm: () {
          GetStorage().erase();
          Get.snackbar(
            "Sign-out Success",
            "Thanks, ${name}.",
            icon: Icon(Icons.person, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: mainColors,
            borderRadius: 10,
            margin: EdgeInsets.all(15),
            colorText: Colors.white,
            duration: Duration(seconds: 4),
            isDismissible: true,
            // dismissDirection: SnackDismissDirection.HORIZONTAL,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          Get.offNamed(Routes.LOGIN);
        },
        barrierDismissible: false,
        radius: 10,
        content: Text('Yakin akan keluar?'));
    isloading.value = false;
  }

  @override
  void onInit() {
    getbox();
    super.onInit();
  }
}
