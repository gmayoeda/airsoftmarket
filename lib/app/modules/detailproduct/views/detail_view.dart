// ignore_for_file: must_be_immutable

import 'package:airsoftmarket/app/data/server.dart';
import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:airsoftmarket/app/widget/loading_view.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends StatelessWidget {
  late DetailController cx;

  @override
  Widget build(BuildContext context) {
    cx = Get.find<DetailController>();

    cx.callItemProduct(Get.arguments.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('DETAIL PRODUCTS'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: 20),
          Obx(
            () => cx.isLoading == false
                ? Container(
                    // padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: FittedBox(
                            child: Text(
                              '${cx.prd.value.data!.name}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Image.network(
                              Server.urlImg + "${cx.prd.value.data!.photo}",
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                    "assets/images/image-error.png");
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.IMAGE,
                                        arguments: cx.prd.value.data!.photo);
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.blue,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search, color: Colors.blue,
                                          //
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "View Image",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.EDIT, arguments: [
                                      cx.prd.value.data!.id,
                                      cx.prd.value.data!.name,
                                      cx.prd.value.data!.description,
                                      cx.prd.value.data!.price,
                                      cx.prd.value.data!.photo
                                    ]);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.white),
                                      SizedBox(width: 5),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    cx.deleteItemProduct(
                                        cx.prd.value.data!.id.toString());
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.white),
                                      SizedBox(width: 5),
                                      Text(
                                        'Hapus',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Description:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(
                          '${cx.prd.value.data!.description}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                : LoadingView(),
          ),
        ],
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
                      'Best Price :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    FittedBox(
                      child: Text(
                        "Rp. " +
                            CurrencyTextInputFormatter(
                                    locale: 'id', symbol: '', decimalDigits: 0)
                                .format(('${cx.prd.value.data!.price}')),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
