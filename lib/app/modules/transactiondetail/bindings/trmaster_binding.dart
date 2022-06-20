import 'package:get/get.dart';

import '../controllers/transactiondetail_controller.dart';

class TrDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrDetailController>(
      () => TrDetailController(),
    );
  }
}
