import 'dart:io';

import 'package:airsoftmarket/app/data/dialog.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddController extends GetxController {
  final GlobalKey<FormState> AddFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxString token = "".obs;
  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      token.value = users['token'] ?? "";
    } else {
      print('no getbox!');
    }
  }

  File? image1;
  Future getImage(ImageSource imageSource) async {
    _isLoading.value = true;
    final ImagePicker _picker = ImagePicker();
    // Capture a photo
    final imagePicked =
        await _picker.pickImage(source: imageSource, imageQuality: 30);

    if (imagePicked != null) {
      image1 = File(imagePicked.path);
      _isLoading.value = false;
    } else {
      if (image1 != null) {
        return image1;
      }
    }
    update();
  }

  void add() {
    final isValid = AddFormKey.currentState!.validate();
    if (!isValid) {
      print("Check form!");
      return;
    }
    AddFormKey.currentState!.save();

    if (image1 == null) {
      Get.defaultDialog(
          title: "File Image",
          textCancel: "Kembali",
          confirmTextColor: Colors.white,
          // barrierDismissible: false,
          radius: 5,
          content: Text('Image tidak boleh kosong!'));
    } else {
      _isLoading.value = true;
      ProductProvider()
          .postProduct(
              token.value,
              name.text,
              description.text,
              price.text
                  .replaceAll("Rp. ", "")
                  .replaceAll(",", "")
                  .replaceAll(".", ""),
              image1!)
          .then((_) {
        Get.snackbar(
          'Add Product',
          "Berhasil Menambahkan Product",
          icon: Icon(Icons.add_to_photos_rounded, color: Colors.white),
        );
        Get.offAllNamed(Routes.NAVBOTTOM);
      }).onError((error, stackTrace) {
        showSnackBar(error, onButtonClick: () {});
      });
      _isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getbox();
    super.onReady();
  }
}
