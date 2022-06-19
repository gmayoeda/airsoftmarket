import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TrMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrMasterController>(
      () => TrMasterController(),
    );
  }
}
