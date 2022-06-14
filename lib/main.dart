// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'FontLato',
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}