import 'package:flutter/material.dart';

enum Flavor { dev, production }

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;
  final String appName;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    @required flavor,
    @required baseUrl,
    appName = "Airsoft Market",
  }) {
    _instance ??= FlavorConfig._initialize(flavor, baseUrl, appName);
    return _instance!;
  }

  FlavorConfig._initialize(this.flavor, this.baseUrl, this.appName);

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.flavor == Flavor.production;
  static bool isDevelopment() => _instance!.flavor == Flavor.dev;
}
