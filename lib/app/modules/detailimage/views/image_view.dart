// ignore_for_file: must_be_immutable

import 'package:airsoftmarket/app/data/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../controllers/image_controller.dart';

class ImageView extends StatelessWidget {
  late ImageController cx;

  @override
  Widget build(BuildContext context) {
    cx = Get.find<ImageController>();
    cx.getImage(Get.arguments.toString());
    return Scaffold(
      appBar: AppBar(
        leading:
            InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: PinchZoom(
        maxScale: 2.5,
        // onZoomStart: () {
        //   print('Start zooming');
        // },
        // onZoomEnd: () {
        //   print('Stop zooming');
        // },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(Server.urlImg + Get.arguments.toString()),
                fit: BoxFit.fitWidth),
          ),
        ),
      ),
    );
  }
}
