import 'package:airsoftmarket/app/routes/app_pages.dart';
import 'package:airsoftmarket/app/utils/color.dart';
import 'package:airsoftmarket/app/widget/btn_loading.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

import '../../../../widget/btn_widget.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  late LoginController cx;

  @override
  Widget build(BuildContext context) {
    cx = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: GestureDetector(
        child: Form(
          key: cx.LoginFormKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0, bottom: 10),
                          child: Image.asset(
                            "assets/images/airsoftmarket.png",
                            width: 160,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat Datang",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Login Member",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: cx.email,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Masukan Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: cx.pass,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Masukan Kata sandi";
                            } else if (e.length <= 3) {
                              return "Masukan kata sandi lebih dari 3 karakter";
                            }
                            return null;
                          },
                          obscureText: cx.secureText,
                          // style: ,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.vpn_key),
                            hintText: 'Password',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          ),
                        ),
                        Center(
                          child: Obx(
                            () => cx.isLoading == true
                                ? BtnLoading()
                                : ButtonWidget(
                                    icon:
                                        Icon(Icons.login, color: Colors.white),
                                    onClick: () {
                                      cx.login();
                                    },
                                    btnText: "LOGIN",
                                  ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Belum mempunyai akun?  ",
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed(Routes.REGISTER);
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                    color: mainColors,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
