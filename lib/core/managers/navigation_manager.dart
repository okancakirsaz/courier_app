import 'package:flutter/material.dart';

final class NavigationManager {
  final BuildContext context;
  NavigationManager(this.context);
  navigate(Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  navigateAndRemoveUntil(Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}
