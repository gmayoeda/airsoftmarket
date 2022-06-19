// ignore_for_file: must_be_immutable

import 'package:airsoftmarket/app/data/models/airsoft.dart';
import 'package:airsoftmarket/app/data/server.dart';
import 'package:airsoftmarket/app/modules/cart/controllers/cart_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowCart extends StatelessWidget {
  CartController cx = Get.find<CartController>();
  late Airsoft airsoft;
  late int index;
  RowCart({required this.airsoft, required this.index});

  @override
  Widget build(BuildContext context) {
    // return Container();
    return _buildRowProduct();
  }

  Widget _buildRowProduct() {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: new BorderRadius.circular(5.0)),
              child: Image.network(
                Server.urlImg + airsoft.image,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/image-error.png");
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      airsoft.name,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Rp. " +
                        CurrencyTextInputFormatter(
                                locale: 'id', symbol: '', decimalDigits: 0)
                            .format(('${airsoft.price}')),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Subtotal - Rp. " +
                        CurrencyTextInputFormatter(
                                locale: 'id', symbol: '', decimalDigits: 0)
                            .format((int.parse(airsoft.price) * airsoft.qty)
                                .toString()),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildQty()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQty() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => cx.deleteItem(index),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  width: 1,
                  color: Colors.red,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete, color: Colors.red,
                  //
                  size: 18,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Remove",
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => cx.minusQty(airsoft, index),
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 1)),
                child: Icon(
                  Icons.remove,
                  //
                  size: 18,
                ),
              ),
            ),
            SizedBox(
              width: 7,
            ),

            /// disi qty yang diambil dari object buku book_on_cart
            Text(airsoft.qty.toString(),
                style: TextStyle(
                    //
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold)),
            SizedBox(
              width: 7,
            ),
            InkWell(
              onTap: () => cx.updateQty(airsoft, index),
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 1)),
                child: Icon(
                  Icons.add,
                  //
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
