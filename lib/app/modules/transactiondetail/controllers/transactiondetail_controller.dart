import 'package:airsoftmarket/app/data/models/transaction_detail.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:airsoftmarket/app/widget/dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TrDetailController extends GetxController {
  RxString token = "".obs;
  RxInt grand_total = 0.obs;

  RxList<Detail> _list_trdetail = <Detail>[].obs;
  RxList get list_trdetail => _list_trdetail;

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      token.value = users['token'];
    } else {
      print('no getbox!');
    }
  }

  void getGrandTotal() {
    grand_total.value = 0;
    for (int i = 0; i < list_trdetail.length; i++) {
      grand_total = grand_total +
          int.parse(list_trdetail[i].price * list_trdetail[i].qty);
      print(grand_total);
    }
  }

  void getTransactionDetail(String id) {
    _isLoading.value = true;
    ProductProvider()
        .GetTransactionDetail(token.value, id)
        .then((TransactionDetail trdetail) {
      if (trdetail.data!.detail!.isNotEmpty) {
        list_trdetail.addAll(trdetail.data!.detail!);
      }
      // getGrandTotal();
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
