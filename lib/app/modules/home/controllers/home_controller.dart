import 'package:airsoftmarket/app/data/dialog.dart';
import 'package:airsoftmarket/app/data/models/product_model.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  String url = "https://openapi.mrstein.web.id/";
  RxString name = "".obs, email = "".obs, token = "".obs;

  RxList<Results> _list_prd = <Results>[].obs;

  RxList get list_prd => _list_prd;

  RxBool _isNoLoadMore = false.obs;

  bool get isNoLoadMore => _isNoLoadMore.value;

  int page = 1;

  RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  int getItemLength() {
    if (_isNoLoadMore.value == true) {
      return _list_prd.length;
    }
    return _list_prd.length + 1;
  }

  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      name.value = users['name'];
      email.value = users['email'];
      token.value = users['token'];
      print(token.value);
    } else {
      print('no getbox!');
    }
  }

  void callProduct({bool refresh = false}) {
    if (refresh == true) {
      _isNoLoadMore.value = false;
      page = 1;
      _list_prd.clear();
    }
    _isLoading.value = true;
    ProductProvider().getProduct(token.value, page).then((Product prd) {
      _isLoading.value = false;
      if (prd.data!.results!.isEmpty) {
        _isNoLoadMore.value = true;
      }
      if (prd.data!.results!.isNotEmpty) {
        page++;
        list_prd.addAll(prd.data!.results!);
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  @override
  void onReady() {
    getbox();
    callProduct();
    super.onReady();
  }
}
