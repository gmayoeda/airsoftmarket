import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    // final data = homeC.findById(Get.arguments);
    // controller.name.text = data.name!;
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT PRODUCT'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
