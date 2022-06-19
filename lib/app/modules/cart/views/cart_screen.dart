// ignore_for_file: must_be_immutable

import 'package:airsoftmarket/app/modules/cart/controllers/cart_controller.dart';
import 'package:airsoftmarket/app/modules/cart/views/row_cart.dart';
import 'package:airsoftmarket/app/utils/color.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Grand Total : Rp. " +
                                      CurrencyTextInputFormatter(
                                              locale: 'id',
                                              symbol: '',
                                              decimalDigits: 0)
                                          .format(('${cx.grand_total.value}')),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  cx.submitTransaction();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: mainColors,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                      child: Text(
                                    "Submit",
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
    return ListView.builder(
        itemBuilder: (ctx, index) => Container(
              height: 150,
              margin: EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(width: 0.5, color: Colors.grey.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: RowCart(
                airsoft: cx.cart[index],
                index: index,
              ),
            ),
        // separatorBuilder: (ctx, index) => Divider(
        //       color: Colors.black54,
        //     ),
        itemCount: cx.cart.length);
  }
}
