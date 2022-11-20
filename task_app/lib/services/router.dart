import 'package:flutter/material.dart';
import 'package:task_app/screens/pending_screens.dart';
import 'package:task_app/screens/recycle_bin.dart';
import 'package:task_app/screens/tab_screens.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.name:
        return MaterialPageRoute(builder: (_) => RecycleBin());
      case TabScreens.name:
        return MaterialPageRoute(builder: (_) => TabScreens());
      default:
        return null;
    }
  }
}
