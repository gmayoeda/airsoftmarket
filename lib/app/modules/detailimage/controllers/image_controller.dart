import 'package:airsoftmarket/app/widget/dialog.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ImageController extends GetxController {
  RxString token = "".obs;

  RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      token.value = users['token'] ?? "";
    } else {
      print('no getbox!');
    }
  }

  void getImage(image) {
    _isLoading.value = true;
    ProductProvider().getImage(token.value, image).then((_) {
      _isLoading.value = false;
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  @override
  void onInit() {
    getbox();
    super.onInit();
  }
}
