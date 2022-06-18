import 'package:airsoftmarket/app/data/dialog.dart';
import 'package:airsoftmarket/app/data/models/item_product_model.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailController extends GetxController {
  String url = "https://openapi.mrstein.web.id/";
  // String id = "";
  RxString token = "".obs;
  Rx<itemProduct> prd = Rx(itemProduct());

  RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      token.value = users['token'] ?? "";
    } else {
      print('no getbox!');
    }
  }

  void callItemProduct(id) {
    getbox();
    _isLoading.value = true;
    ProductProvider().getItemProduct(id, token.value).then((itemProduct item) {
      print(item.data!.name);
      if (item.success = true) {
        prd.value = item;
        _isLoading.value = false;
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  void deleteItemProduct(id) {
    getbox();
    Get.defaultDialog(
        title: "Delete",
        textCancel: "Kembali",
        textConfirm: "Delete",
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          ProductProvider().deleteProduct(id, token.value).then((_) {
            Get.snackbar(
              'Delete Product',
              "Berhasil Delete Data Product",
              icon: Icon(Icons.delete_sweep, color: Colors.white),
            );
            Get.offAllNamed(Routes.NAVBOTTOM);
            _isLoading.value = false;
          }).onError((error, stackTrace) {
            showSnackBar(error, onButtonClick: () {});
          });
        },
        barrierDismissible: false,
        radius: 10,
        content: Text('Yakin akan diHapus?'));
  }

  @override
  void onReady() {
    getbox();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
