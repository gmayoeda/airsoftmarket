// ignore_for_file: must_be_immutable

import 'package:airsoftmarket/app/data/models/airsoft.dart';
import 'package:airsoftmarket/app/modules/cart/controllers/cart_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: new BorderRadius.circular(5.0)),
              child: Image.network(
                cx.url + "uploads/" + airsoft.image,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    airsoft.name,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    "Total - Rp. " +
                        CurrencyTextInputFormatter(
                                locale: 'id', symbol: '', decimalDigits: 0)
                            .format(('${airsoft.price * airsoft.qty}')),
                  ),
                  SizedBox(
                    height: 7,
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
                border: Border.all(width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  //
                  size: 18,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Remove",
                  style: TextStyle(
                      //
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
