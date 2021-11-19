import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static Future<dynamic> pushNamed(String routeName) async {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Future<dynamic> pushReplacementNamed(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}