import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';

class splashscreenController extends GetxController {
  selection() {
    return Timer(Duration(seconds: 3), () {
      print(GetStorage().read('users'));
      if (GetStorage().hasData("users")) {
        // Get.offAllNamed(Routes.HOME);
        Get.offAllNamed(Routes.NAVBOTTOM);
        print("screen -> data users ada ==========================");
      } else {
        Get.offAllNamed(Routes.LOGIN);
        print("screen -> data users null ==========================");
      }
    });
  }

  @override
  void onReady() {
    selection();
    super.onReady();
  }
}
