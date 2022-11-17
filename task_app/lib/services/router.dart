import 'package:flutter/material.dart';
import 'package:task_app/screens/home_screens.dart';
import 'package:task_app/screens/recycle_bin.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.name:
        return MaterialPageRoute(builder: (_) => RecycleBin());
      case HomeScreens.name:
        return MaterialPageRoute(builder: (_) => HomeScreens());
      default:
        return null;
    }
  }
}
