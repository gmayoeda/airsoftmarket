// ignore_for_file: unused_import

import 'package:airsoftmarket/app/data/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'package:intl/intl.dart';

void main() async {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // FlavorConfig(
  //   flavor: Flavor.dev,
  //   baseUrl: 'https://openapi.mrstein.web.id/',
  //   appName: '[DEV] Airsoft Market',
  // );
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
