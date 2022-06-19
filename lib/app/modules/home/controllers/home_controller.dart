// ignore_for_file: unnecessary_type_check

import 'package:airsoftmarket/app/data/dialog.dart';
import 'package:airsoftmarket/app/data/models/airsoft.dart';
import 'package:airsoftmarket/app/data/models/product_model.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  String url = "https://openapi.mrstein.web.id/";
  RxString name = "".obs, email = "".obs, token = "".obs;

  RxList<Results> _list_prd = <Results>[].obs;
  RxList get list_prd => _list_prd;

  RxList<Airsoft> items = <Airsoft>[].obs;
  RxList<Airsoft> cart = <Airsoft>[].obs;

  RxBool _isNoLoadMore = false.obs;
  bool get isNoLoadMore => _isNoLoadMore.value;

  int page = 1;

  // int qty = 0.obs as int;

  RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  int getItemLength() {
    if (_isNoLoadMore.value == true) {
      return _list_prd.length;
    }
    return _list_prd.length + 1;
  }

  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      name.value = users['name'];
      email.value = users['email'];
      token.value = users['token'];
      // print(token.value);
    } else {
      print('no getbox!');
    }
  }

  void getStorage() {
    if (GetStorage().hasData("items_cart")) {
      List<dynamic> value = GetStorage().read("items_cart");
      if (value is List) {
        print(GetStorage().read("items_cart"));
        cart.clear();
        cart.addAll(value.map((e) => Airsoft.fromMap(Map.from(e))).toList());
      }

      listenKey();
    }
  }

  void listenKey() {
    GetStorage().listenKey("items_cart", (value) {
      if (value is List) {
        cart.clear();
        cart.addAll(value.map((e) => Airsoft.fromMap(Map.from(e))).toList());
      }
    });
  }

  void callProduct({bool refresh = false}) {
    if (refresh == true) {
      _isNoLoadMore.value = false;
      page = 1;
      _list_prd.clear();
    }
    _isLoading.value = true;
    ProductProvider().getProduct(token.value, page).then((Product prd) {
      _isLoading.value = false;
      if (prd.data!.results!.isEmpty) {
        _isNoLoadMore.value = true;
      }
      if (prd.data!.results!.isNotEmpty) {
        page++;
        list_prd.addAll(prd.data!.results!);
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  // ALL ABOUT CART

  void addToCart(int id, String name, price, image) async {
    // var id = items.length + 1;
    var qty = 1;

    Airsoft? airsoft_in_cart =
        cart.firstWhereOrNull((Airsoft cart_item) => cart_item.id == id);

    if (airsoft_in_cart == null) {
      items.add(
          Airsoft(id: id, name: name, image: image, price: price, qty: qty));
      // print("itemsadd");

      GetStorage().write("items_cart",
          items.map((Airsoft airsoft) => airsoft.toJson()).toList());
      print(GetStorage().read('items_cart'));
      Get.snackbar(
        'Add to Cart',
        "Berhasil ditambahkan ke Cart",
        icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.white),
      );
    } else {
      Get.snackbar(
        'Add to Cart',
        "Produk sudah ada diCart",
        icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.white),
      );
    }
  }

  // void deleteItem(int id) async {
  //   cart.removeWhere((Airsoft airsoft_in_cart) => airsoft_in_cart.id == id);
  //   GetStorage().write(
  //       "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  // }

  ///row pada variable cart diupdate qtynya
  // void updateQty(Airsoft airsoft) async {
  //   airsoft.qty = airsoft.qty + 1;
  //   cart.removeWhere(
  //       (Airsoft airsoft_in_cart) => airsoft_in_cart.id == airsoft.id);
  //   cart.add(airsoft);
  //   GetStorage().write(
  //       "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  // }

  // void minusQty(Airsoft airsoft) async {
  //   if (airsoft.qty == 1) {
  //     cart.removeWhere(
  //         (Airsoft airsoft_in_cart) => airsoft_in_cart.id == airsoft.id);
  //   } else {
  //     cart.removeWhere(
  //         (Airsoft airsoft_in_cart) => airsoft_in_cart.id == airsoft.id);
  //     airsoft.qty = airsoft.qty - 1;
  //     cart.add(airsoft);
  //   }
  //   GetStorage().write(
  //       "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  // }

  @override
  void onReady() {
    getbox();
    getStorage();
    callProduct();
    super.onReady();
  }
}
