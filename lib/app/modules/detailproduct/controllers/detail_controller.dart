import 'package:airsoftmarket/app/data/dialog.dart';
import 'package:airsoftmarket/app/data/models/item_product_model.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailController extends GetxController {
  String url = "https://openapi.mrstein.web.id/";
  RxString token = "".obs;
  Rx<itemProduct> prd = Rx(itemProduct());

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

  void callItemProduct(id) {
    getbox();
    _isLoading.value = true;
    ProductProvider().getItemProduct(id, token.value).then((itemProduct item) {
      print(item.data!.name);
      if (item.success = true) {
        prd.value = item;
        _isLoading.value = false;
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  @override
  void onReady() {
    getbox();
    super.onReady();
  }
}
