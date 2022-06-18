// ignore_for_file: must_be_immutable
import 'package:airsoftmarket/app/modules/edit/controllers/edit_controller.dart';
import 'package:airsoftmarket/app/widget/btn_loading.dart';
import 'package:airsoftmarket/app/widget/btn_widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditView extends StatelessWidget {
  late EditController cx;

  var data = Get.arguments!;

  @override
  Widget build(BuildContext context) {
    cx = Get.find<EditController>();
    cx.id.text = '${data[0]}';
    cx.name.text = '${data[1]}';
    cx.description.text = '${data[2]}';
    cx.price.text = 'Rp. ' +
        NumberFormat.currency(locale: 'en', symbol: '', decimalDigits: 0)
            .format(int.parse('${data[3]}'));

    // print(cx.id.text);

    return Scaffold(
      appBar: AppBar(
        title: Text('ADD PRODUCT'),
        centerTitle: true,
      ),
      body: Form(
        key: cx.EditFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(height: 15),
              TextFormField(
                controller: cx.name,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (e) {
                  if (e!.isEmpty) {
                    return "Input Name!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 18), //label style
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: cx.description,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (e) {
                  if (e!.isEmpty) {
                    return "Input Description!";
                  }
                  return null;
                },
                // minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(fontSize: 18), //label style
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Description',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: cx.price,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'en',
                    symbol: 'Rp. ',
                    decimalDigits: 0,
                  )
                ],
                validator: (e) {
                  if (e!.isEmpty) {
                    return "Input Price!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(fontSize: 18), //label style
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Price',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
              ),
              SizedBox(height: 15),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF).withOpacity(0.80),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.black54),
                    ),
                    child: Obx(
                      () => cx.isLoading == false && cx.image1 != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(cx.image1!,
                                  height: 190,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                  cx.url + "uploads/${data[4]}",
                                  height: 190,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  PopupMenuButton(
                    icon: Icon(
                      Icons.cloud_upload_sharp,
                      size: 32.0,
                      color: Colors.orange,
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            cx.getImage(ImageSource.camera);
                          },
                          value: '1',
                          child: Row(children: [
                            const Icon(Icons.camera_alt),
                            Text('   Camera'),
                          ]),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            cx.getImage(ImageSource.gallery);
                          },
                          value: '2',
                          child: Row(children: [
                            const Icon(Icons.photo_library),
                            Text('   Gallery'),
                          ]),
                        ),
                      ];
                    },
                    // onSelected: (String value) {
                    // },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Obx(() => cx.isLoading == true
                  ? BtnLoading()
                  : ButtonWidget(
                      icon: Icon(Icons.add_circle_outline, color: Colors.white),
                      onClick: () {
                        cx.updatePrd();
                      },
                      btnText: "UPDATE PRODUCT",
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
