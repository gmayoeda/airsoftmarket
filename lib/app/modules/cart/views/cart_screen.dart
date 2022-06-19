// ignore_for_file: must_be_immutable

import 'package:airsoftmarket/app/modules/cart/controllers/cart_controller.dart';
import 'package:airsoftmarket/app/modules/cart/views/row_cart.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartScreen extends StatelessWidget {
  late CartController cx;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CartController>(
      () => CartController(),
    );

    cx = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CART",
        ),
      ),
      body: Container(
        // color: Colors.black,
        padding: EdgeInsets.all(10),
        child: Obx(
          () {
            return cx.cart.isEmpty
                ? _buildEmpty()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildList()),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Grand Total : Rp. " +
                                    CurrencyTextInputFormatter(
                                            locale: 'id',
                                            symbol: '',
                                            decimalDigits: 0)
                                        .format(('${cx.grand_total.value}')),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  // cx.onPressProceed();
                                  GetStorage()
                                      .write("items_cart", []).then((value) {
                                    cx.grand_total.value = 0;
                                    cx.cart.clear();
                                    Get.back();
                                    Get.snackbar(
                                        "Message", "Transaction succeed ! ",
                                        colorText: Colors.white,
                                        backgroundColor: Color(0xff4D4D4D),
                                        snackPosition: SnackPosition.BOTTOM);
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                      child: Text(
                                    "Proceed",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text("Your Cart is Empty"),
    );
  }

  Widget _buildList() {
    return ListView.separated(
        itemBuilder: (ctx, index) => RowCart(
              airsoft: cx.cart[index],
              index: index,
            ),
        separatorBuilder: (ctx, index) => Divider(
              color: Colors.black54,
            ),
        itemCount: cx.cart.length);
  }
}
