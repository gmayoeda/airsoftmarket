import 'package:airsoftmarket/app/widget/loading_view.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/transactiondetail_controller.dart';

// ignore: must_be_immutable
class TransactionDetailView extends StatelessWidget {
  late TrDetailController cx;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TrDetailController>(
      () => TrDetailController(),
    );
    cx = Get.find<TrDetailController>();
    cx.list_trdetail.clear();
    cx.getTransactionDetail(Get.arguments[0].toString());

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('TRANSACTION ' + Get.arguments[1].toString()),
            Text(
              'Period of  ' +
                  DateFormat.yMMMd()
                      .format(DateTime.parse(
                        Get.arguments[2].toString(),
                      ))
                      .toString(),
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Obx(
            () => cx.list_trdetail.isEmpty
                ? LoadingView()
                : ListView.builder(
                    itemCount: cx.list_trdetail.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < cx.list_trdetail.length) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.2)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5.0,
                                offset: Offset(0.0, 2.0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cx.list_trdetail[index].name!,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                cx.list_trdetail[index].description!,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  cx.list_trdetail[index].qty!.toString() +
                                      " / pcs.",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  " Rp. " +
                                      CurrencyTextInputFormatter(
                                              locale: 'id',
                                              symbol: '',
                                              decimalDigits: 0)
                                          .format(
                                              ('${cx.list_trdetail[index].price!.toString()}')),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Rp. " +
                                      CurrencyTextInputFormatter(
                                              locale: 'id',
                                              symbol: '',
                                              decimalDigits: 0)
                                          .format(
                                        (cx.list_trdetail[index].price *
                                                cx.list_trdetail[index].qty)
                                            .toString(),
                                      ),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: Obx(
          () => cx.isLoading == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    cx.list_trdetail.length == 2
                        ? Text(
                            "Rp. " +
                                CurrencyTextInputFormatter(
                                        locale: 'id',
                                        symbol: '',
                                        decimalDigits: 0)
                                    .format(((cx.list_trdetail[0].price *
                                                cx.list_trdetail[0].qty) +
                                            (cx.list_trdetail[1].price *
                                                cx.list_trdetail[1].qty))
                                        .toString()),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )
                        : cx.list_trdetail.length == 1
                            ? Text(
                                "Rp. " +
                                    CurrencyTextInputFormatter(
                                            locale: 'id',
                                            symbol: '',
                                            decimalDigits: 0)
                                        .format((((cx.list_trdetail[0].price *
                                                    cx.list_trdetail[0].qty))
                                                .toString())
                                            .toString()),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              )
                            : Text(''),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
