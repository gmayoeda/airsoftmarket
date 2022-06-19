import 'package:airsoftmarket/app/widget/dialog.dart';
import 'package:airsoftmarket/app/data/models/register_model.dart';
import 'package:airsoftmarket/app/data/providers/auth_provider.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final reg = registerMember();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  bool secureText = true;

  final GlobalKey<FormState> LoginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  showHide() {
    secureText = !secureText;
  }

  void login() {
    final isValid = LoginFormKey.currentState!.validate();
    if (!isValid) {
      print("Check form!");
      return;
    }
    LoginFormKey.currentState!.save();

    AuthProvider().login(email.text, pass.text).then((registerMember reg) {
      _isLoading.value = true;
      Get.snackbar(
        'Login',
        reg.message == "Response Success !"
            ? "Login Berhasil"
            : '${reg.message}',
        icon: Icon(Icons.app_registration_rounded, color: Colors.white),
      );

      if (reg.success == true) {
        Map<String, dynamic> user = {
          "id": reg.data!.id,
          "email": reg.data!.email,
          "name": reg.data!.name,
          "token": reg.data!.token,
        };
        box.write('users', user).then((value) async {
          _isLoading.value = true;
          // await Future.delayed(Duration(seconds: 3));
          Get.offAllNamed(Routes.NAVBOTTOM);
        });
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  @override
  void onInit() {
    // getbox();
    super.onInit();
  }

  @override
  void onClose() {}
}
