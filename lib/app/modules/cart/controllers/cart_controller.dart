// ignore_for_file: unnecessary_type_check

import 'package:airsoftmarket/app/data/models/airsoft.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:airsoftmarket/app/utils/color.dart';
import 'package:airsoftmarket/app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  GetStorage box = GetStorage();
  RxList<Airsoft> cart = <Airsoft>[].obs;
  RxInt sub_total = 0.obs;
  RxInt grand_total = 0.obs;
  RxString token = "".obs;

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void getToken() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      token.value = users['token'] ?? "";
    } else {
      print('no getbox!');
    }
  }

  void getStorage() {
    if (box.hasData("items_cart")) {
      List<dynamic> value = GetStorage().read("items_cart");
      if (value is List) {
        print(GetStorage().read("items_cart"));
        cart.clear();
        cart.addAll(value.map((e) => Airsoft.fromMap(Map.from(e))).toList());
        getGrandTotal();
      }

      listenKey();
    }
  }

  void listenKey() {
    box.listenKey("items_cart", (value) {
      if (value is List) {
        cart.clear();
        cart.addAll(value.map((e) => Airsoft.fromMap(Map.from(e))).toList());
        getGrandTotal();
      }
    });
  }

  void getGrandTotal() {
    grand_total.value = 0;
    for (int i = 0; i < cart.length; i++) {
      grand_total = grand_total + (cart[i].qty * int.parse(cart[i].price));
    }
  }

  void submitTransaction() {
    Get.defaultDialog(
      title: "Submit Transaction",
      content: Text('Lanjutkan Transaksi?'),
      textCancel: "Kembali",
      textConfirm: "Submit",
      confirmTextColor: Colors.white,
      onConfirm: () {
        _isLoading.value = true;
        ProductProvider()
            .postTransaction(token.value, GetStorage().read("items_cart"))
            .then((_) {
          // GetStorage().remove("items_cart");
          GetStorage().write("items_cart", []);
          grand_total.value = 0;
          cart.clear();
          Get.snackbar(
            'Transaction Status',
            "Transaksi berhasil ditambahkan",
            icon: Icon(Icons.delete_sweep, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: mainColors,
            borderRadius: 10,
            margin: EdgeInsets.all(15),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          Get.offAllNamed(Routes.NAVBOTTOM);
          _isLoading.value = false;
        }).onError((error, stackTrace) {
          showSnackBar(error, onButtonClick: () {});
        });
      },
      barrierDismissible: false,
      radius: 10,
    ).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  void deleteItem(int index) async {
    cart.removeAt(index);
    box.write(
        "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  }

  void updateQty(Airsoft airsoft, int index) async {
    cart[index].qty++;
    box.write(
        "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  }

  void minusQty(Airsoft airsoft, int index) async {
    if (airsoft.qty == 1) {
      cart.removeAt(index);
    } else {
      cart[index].qty--;
    }
    box.write(
        "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  }

  @override
  void onReady() {
    getToken();
    getStorage();
    super.onReady();
  }
}
