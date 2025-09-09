import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail");
  
  const NavigationRoute(this.name);
  final String name;
}