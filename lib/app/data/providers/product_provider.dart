import 'dart:io';

import 'package:airsoftmarket/app/data/models/item_product_model.dart';
import 'package:airsoftmarket/app/data/models/product_model.dart';
import 'package:get/get.dart';
import 'dart:math' as Math;

class ProductProvider extends GetConnect {
  String url = "https://openapi.mrstein.web.id/";

  Future<Product> getProduct(String token, page) async {
    final response = await get(
      "$url" + 'airsoft',
      headers: {"Authorization": "Bearer " + token},
      query: {'page': '4'},
    );

    try {
      print("PAGE: $page");
      print("DATA RESPONSE PRODUCT : ${response.body}");
      return Product.fromJson(response.body);
    } catch (e) {
      throw Exception();
    }
  }

  Future<itemProduct> getItemProduct(String id, token) async {
    final response = await get('${url}airsoft/$id',
        headers: {"Authorization": "Bearer " + token});
    // print("$url" + 'airsoft/$id');
    try {
      print("DATA RESPONSE ITEM PRODUCT : ${response.body}");
      return itemProduct.fromJson(response.body);
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> postProduct(
      String token, name, description, price, File file) async {
    int rand = new Math.Random().nextInt(1000000);
    final form = FormData({
      'name': name,
      'description': description,
      'price': price,
      'file': MultipartFile(file, filename: "imageUpload_$rand.jpg"),
    });
    final response = await post(
      "$url" + 'airsoft/add',
      form,
      headers: {"Authorization": "Bearer " + token},
    );
    try {
      print("DATA RESPONSE ADD PRODUCT : ${response.body}");
    } catch (e) {
      throw Exception();
    }
  }
}


  

  // Future<void> editProduct(String id, String name) async {
  //   await patch(
  //     "$url" + 'products/$id.json',
  //     {
  //       "name": name,
  //     },
  //   );
  // }

  

  // Future<void> deleteProduct(String id) async =>
  //     await delete("$url" + 'products/$id.json');

