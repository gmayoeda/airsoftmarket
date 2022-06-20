import 'package:airsoftmarket/app/data/models/transaction_detail.dart';
import 'package:airsoftmarket/app/data/models/transaction_master.dart';
import 'package:airsoftmarket/app/data/providers/product_provider.dart';
import 'package:airsoftmarket/app/widget/dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TrMasterController extends GetxController {
  RxString token = "".obs;

  RxList<Results> _list_trmaster = <Results>[].obs;
  RxList get list_trmaster => _list_trmaster;

  RxList<Detail> _list_trdetail = <Detail>[].obs;
  RxList get list_trdetail => _list_trdetail;

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxBool _isNoLoadMore = false.obs;
  bool get isNoLoadMore => _isNoLoadMore.value;

  int page = 1;

  void getbox() {
    if (GetStorage().hasData('users')) {
      Map<String, dynamic> users = GetStorage().read('users');
      token.value = users['token'];
    } else {
      print('no getbox!');
    }
  }

  int getItemLength() {
    if (_isNoLoadMore.value == true) {
      return _list_trmaster.length;
    }
    return _list_trmaster.length + 1;
  }

  void getTransactionMaster({bool refresh = false}) {
    if (refresh == true) {
      _isNoLoadMore.value = false;
      page = 1;
      _list_trmaster.clear();
    }
    _isLoading.value = true;
    ProductProvider()
        .GetTransactionMaster(token.value, page)
        .then((TransactionMaster trmaster) {
      _isLoading.value = false;
      if (trmaster.data!.results!.isEmpty) {
        _isNoLoadMore.value = true;
      }
      if (trmaster.data!.results!.isNotEmpty) {
        page++;
        list_trmaster.addAll(trmaster.data!.results!);
      }
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  void getTransactionDetail(String id) {
    _isLoading.value = true;
    ProductProvider()
        .GetTransactionDetail(token.value, id)
        .then((TransactionDetail trdetail) {
      // if (trdetail.data!.detail!.isNotEmpty) {
      //   list_trdetail.addAll(trdetail.data!.detail!);
      // }
      _isLoading.value = false;
    }).onError((error, stackTrace) {
      showSnackBar(error, onButtonClick: () {});
    });
  }

  @override
  void onInit() {
    getbox();
    getTransactionMaster();
    super.onInit();
  }
}
