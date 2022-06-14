// ignore_for_file: must_be_immutable
import 'package:airsoftmarket/app/modules/home/controllers/home_controller.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:airsoftmarket/app/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class HomeView extends StatelessWidget {
  // late Product product;
  // HomeView({required this.product});

  late HomeController cx;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    cx = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL PRODUCTS'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.ADD),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => cx.list_prd.isEmpty
              ? LoadingView()
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      if (cx.isNoLoadMore == false) {
                        if (cx.isLoading == false) {
                          cx.callProduct();
                        }
                      }
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cx.callProduct(refresh: true);
                    },
                    child: ListView.builder(
                      itemCount: cx.getItemLength(),
                      itemBuilder: (BuildContext context, int index) {
                        final prd = cx.list_prd[index];

                        if (index < cx.list_prd.length) {
                          return InkWell(
                            onTap: (() {
                              if (prd.id.toString() == "") {
                              } else {
                                print(prd.id);
                                Get.toNamed(Routes.DETAIL, arguments: prd.id);
                                // cx.callItemProduct(prd.id.toString());
                              }
                            }),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: const EdgeInsets.all(8),
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
                                children: [
                                  SizedBox(height: 5),
                                  FittedBox(
                                    child: Text(
                                      prd.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 150,
                                        height: 130,
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 150,
                                          child: Image.network(
                                            cx.url + "uploads/" + prd.photo,
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  "assets/images/image-error.png");
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: 150,
                                          height: 120,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                prd.description,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              SizedBox(height: 10),
                                              FittedBox(
                                                child: Text(
                                                  "Rp. " +
                                                      CurrencyTextInputFormatter(
                                                              locale: 'id',
                                                              symbol: '',
                                                              decimalDigits: 0)
                                                          .format(
                                                              ('${prd.price}')),
                                                  // textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return LoadingView();
                        }
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
