import 'dart:io';

import 'package:airsoftmarket/app/data/models/item_product_model.dart';
import 'package:airsoftmarket/app/data/models/product_model.dart';
import 'package:airsoftmarket/app/data/server.dart';
import 'package:get/get.dart';
import 'dart:math' as Math;

class ProductProvider extends GetConnect {
  Future<Product> getProduct(String token, page) async {
    final response = await get(
      Server.url + 'airsoft',
      headers: {"Authorization": "Bearer " + token},
      query: {'page': '$page'},
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
    final response = await get(Server.url + 'airsoft/$id',
        headers: {"Authorization": "Bearer " + token});
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
      Server.url + 'airsoft/add',
      form,
      headers: {"Authorization": "Bearer " + token},
    );
    try {
      print("DATA RESPONSE ADD PRODUCT : ${response.body}");
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> updateProduct(
      String token, id, name, description, price) async {
    final form = FormData({
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    });
    final response = await post(
      Server.url + 'airsoft/update',
      form,
      headers: {"Authorization": "Bearer " + token},
    );
    try {
      print("DATA RESPONSE UPDATE PRODUCT : ${response.body}");
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> updateProductWimage(
      String token, id, name, description, price, File file) async {
    int rand = new Math.Random().nextInt(1000000);
    final form = FormData({
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'file': MultipartFile(file, filename: "imageUpload_$rand.jpg"),
    });
    final response = await post(
      Server.url + 'airsoft/update',
      form,
      headers: {"Authorization": "Bearer " + token},
    );
    try {
      print("DATA RESPONSE UPDATE PRODUCT : ${response.body}");
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> deleteProduct(String id, token) async {
    final response = await delete(Server.url + 'airsoft/delete/$id',
        headers: {"Authorization": "Bearer " + token});
    try {
      print("DATA RESPONSE DELETE PRODUCT : ${response.body}");
      return itemProduct.fromJson(response.body);
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> getImage(String token, image) async {
    print(Server.urlImg + image);
    final response = await get(
      Server.urlImg + image,
      headers: {"Authorization": "Bearer " + token},
      // query: image,
    );

    try {
      print("DATA RESPONSE SHOW IMAGE : ${response.body}");
    } catch (e) {
      throw Exception();
    }
  }
}
