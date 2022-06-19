// ignore_for_file: unnecessary_type_check

import 'package:airsoftmarket/app/data/models/airsoft.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  String url = "https://openapi.mrstein.web.id/";
  GetStorage box = GetStorage();
  RxList<Airsoft> cart = <Airsoft>[].obs;
  RxInt sub_total = 0.obs;
  RxInt grand_total = 0.obs;

  void getStorage() {
    if (box.hasData("items_cart")) {
      List<dynamic> value = GetStorage().read("items_cart");
      if (value is List) {
        print(GetStorage().read("items_cart"));
        cart.clear();
        cart.addAll(value.map((e) => Airsoft.fromMap(Map.from(e))).toList());
        getGrandTotal();
      }

      listenKey();
    }
  }

  void listenKey() {
    box.listenKey("items_cart", (value) {
      if (value is List) {
        cart.clear();
        cart.addAll(value.map((e) => Airsoft.fromMap(Map.from(e))).toList());
        getGrandTotal();
      }
    });
  }

  void getGrandTotal() {
    grand_total.value = 0;
    for (int i = 0; i < cart.length; i++) {
      grand_total = grand_total + (cart[i].qty * int.parse(cart[i].price));
    }
  }

  // void onPressProceed(){
  //     Get.defaultDialog(
  //         title: "Really want to proceed ?",
  //         // onConfirm: (){

  //         // },
  //         actions: [
  //           ElevatedButton(
  //               style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all(Colors.black)
  //               ),
  //               onPressed: (){
  //                 Get.back();
  //               },
  //               child: Text("Cancel")
  //           ),
  //           ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all(Colors.yellow)
  //               ),
  //               onPressed: (){
  //                 box.write("items_cart", []).then((value){
  //                   grand_total.value=0;
  //                   cart.clear();
  //                   Get.back();
  //                   Get.snackbar("Message", "Transaction succeed ! ",colorText: Colors.white,backgroundColor: Color(0xff4D4D4D),snackPosition: SnackPosition.BOTTOM);
  //                 });
  //               },
  //               child: Text("Confirm",style: TextStyle(color: Colors.black),)
  //           )
  //         ],
  //         backgroundColor: Color(0xff4D4D4D),
  //         titleStyle: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontSize: 17,fontWeight: FontWeight.bold),
  //         // textConfirm: "Confirm",
  //         // textCancel: "Cancel",
  //         // cancelTextColor: Colors.white,
  //         // confirmTextColor: Colors.black,
  //         // buttonColor: Colors.yellow,
  //         content: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               width: 300,
  //               height: 200,
  //               child: ListView.separated(
  //                 separatorBuilder: (_,i)=>Divider(),
  //                 itemCount: cart.length,
  //                 itemBuilder: (_,index){
  //                   return ListTile(
  //                     leading: Container(
  //                       width: 60,
  //                       height: 80,
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.all(Radius.circular(10)),
  //                           image: DecorationImage(
  //                               fit: BoxFit.cover,
  //                               image: AssetImage(cart[index].image)
  //                           )
  //                       ),
  //                     ),
  //                     title:Text(cart[index].name,style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontWeight: FontWeight.bold,fontSize: 12),),
  //                     subtitle: Text("Rp. "+Formatter.format.format(cart[index].price)+" x "+cart[index].qty.toString(),
  //                       style: TextStyle(fontFamily: "Poppins",color: Colors.white,fontSize: 10),),
  //                   );
  //                 },
  //               ),
  //             ),
  //             SizedBox(height: 5,),
  //             Text(userSession["name"],style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 12),),
  //             SizedBox(height: 5,),
  //             Text(userSession["email"],style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 12),),
  //             SizedBox(height: 5,),
  //             Text("Total Rp. "+Formatter.format.format(grand_total.value),style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 12),)
  //           ],
  //         )
  //     );
  // }

  void deleteItem(int index) async {
    cart.removeAt(index);
    box.write(
        "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  }

  void updateQty(Airsoft airsoft, int index) async {
    cart[index].qty++;
    box.write(
        "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  }

  void minusQty(Airsoft airsoft, int index) async {
    if (airsoft.qty == 1) {
      cart.removeAt(index);
    } else {
      cart[index].qty--;
    }
    box.write(
        "items_cart", cart.map((Airsoft airsoft) => airsoft.toJson()).toList());
  }

  @override
  void onReady() {
    getStorage();
    super.onReady();
  }
}
