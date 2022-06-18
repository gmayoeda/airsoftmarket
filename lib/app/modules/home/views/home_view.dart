// ignore_for_file: must_be_immutable, unused_element
import 'package:airsoftmarket/app/data/models/airsoft.dart';
import 'package:airsoftmarket/app/modules/home/controllers/home_controller.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:airsoftmarket/app/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class HomeView extends StatelessWidget {
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
            onPressed: () => Get.toNamed(Routes.CART),
            icon: Icon(Icons.shopping_cart),
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
                        // final prd = cx.list_prd[index];

                        if (index < cx.list_prd.length) {
                          return InkWell(
                            onTap: (() {
                              if (cx.list_prd[index].id.toString() == "") {
                              } else {
                                print(cx.list_prd[index].id);
                                Get.toNamed(Routes.DETAIL,
                                    arguments: cx.list_prd[index].id);
                                // cx.callItemProduct(cx.list_prd[index].id.toString());
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
                                      cx.list_prd[index].name,
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
                                        height: 150,
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 150,
                                          child: Image.network(
                                            cx.url +
                                                "uploads/" +
                                                cx.list_prd[index].photo,
                                            fit: BoxFit.fitWidth,
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
                                          height: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  cx.list_prd[index]
                                                      .description,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
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
                                                              ('${cx.list_prd[index].price}')),
                                                  // textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              // _buildQty(airsoft),
                                              // SizedBox(height: 10),
                                              _buildAddToCart(index),
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
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD);
          },
          // backgroundColor: Colors.green,
          child: const Icon(Icons.add_to_photos_sharp)),
    );
  }

  Widget _buildAddToCart(index) {
    return InkWell(
      onTap: () {
        cx.addToCart(
            cx.list_prd[index].name,
            cx.list_prd[index].price
                .toString()
                .replaceAll("Rp. ", "")
                .replaceAll(".", ""),
            cx.list_prd[index].photo);
      },
      child: Container(
        height: 32,
        width: 115,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_checkout_sharp,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "Add To Cart",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
