import 'package:airsoftmarket/app/widget/dialog.dart';
import 'package:airsoftmarket/app/data/providers/auth_provider.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:airsoftmarket/app/data/models/register_model.dart';

class RegisterController extends GetxController {
  final box = GetStorage();

  bool secureText = true;

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final GlobalKey<FormState> LoginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  void register() {
    final isValid = LoginFormKey.currentState!.validate();
    if (!isValid) {
      print("Check form!");
      return;
    }
    LoginFormKey.currentState!.save();

    _isLoading.value = true;

    AuthProvider()
        .register(email.text, name.text, pass.text)
        .then((registerMember reg) {
      Get.snackbar(
        'Register',
        reg.message == "Response Success !"
            ? "Registrasi Berhasil"
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
        _isLoading.value = false;
        box.write('users', user).then((value) {
          Get.offAllNamed(Routes.NAVBOTTOM);
        });
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    secureText = !secureText;
    super.onReady();
  }

  @override
  void onClose() {}
}
