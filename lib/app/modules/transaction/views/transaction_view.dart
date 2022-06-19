import 'package:airsoftmarket/app/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/transaction_controller.dart';

// ignore: must_be_immutable
class TransactionView extends StatelessWidget {
  late TrMasterController cx;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TrMasterController>(
      () => TrMasterController(),
    );
    cx = Get.find<TrMasterController>();

    return Scaffold(
      appBar: AppBar(title: Text('TRANSACTION'), centerTitle: true),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Obx(
            () => cx.list_trmaster.isEmpty
                ? LoadingView()
                : ListView.builder(
                    itemCount: cx.list_trmaster.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < cx.list_trmaster.length) {
                        return Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.article_rounded),
                                  SizedBox(width: 5),
                                  Text(
                                    cx.list_trmaster[index].transCode,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(DateTime.parse(
                                        cx.list_trmaster[index].date))
                                    .toString(),
                                // cx.list_trmaster[index].date,
                                style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w500),
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
    );
  }
}
