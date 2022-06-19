import 'package:airsoftmarket/app/data/models/transaction_master.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:airsoftmarket/app/widget/dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TrMasterController extends GetxController {
  RxString token = "".obs;

  RxList<Results> _list_trmaster = <Results>[].obs;
  RxList get list_trmaster => _list_trmaster;

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

  void submitTransaction() {
    _isLoading.value = true;
    ProductProvider()
        .GetTransactionMaster(token.value)
        .then((TransactionMaster trmaster) {
      if (trmaster.data!.results!.isNotEmpty) {
        list_trmaster.addAll(trmaster.data!.results!);
      }
      _isLoading.value = false;
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  @override
  void onInit() {
    getbox();
    submitTransaction();
    super.onInit();
  }
}
