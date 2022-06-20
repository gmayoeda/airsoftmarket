import 'package:airsoftmarket/app/routes/app_pages.dart';
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
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent) {
                        if (cx.isNoLoadMore == false) {
                          if (cx.isLoading == false) {
                            cx.getTransactionMaster();
                          }
                        }
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        cx.getTransactionMaster(refresh: true);
                      },
                      child: ListView.builder(
                        itemCount: cx.getItemLength(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index < cx.list_trmaster.length) {
                            return Column(
                              children: [
                                Card(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.TRDETAIL, arguments: [
                                        cx.list_trmaster[index].id,
                                        cx.list_trmaster[index].transCode,
                                        cx.list_trmaster[index].date
                                      ]);
                                    },
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.article_rounded),
                                              SizedBox(width: 8),
                                              Text(
                                                cx.list_trmaster[index]
                                                    .transCode,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            DateFormat.yMMMd()
                                                .format(DateTime.parse(cx
                                                    .list_trmaster[index].date))
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.blue[700],
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(Icons.navigate_next),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
