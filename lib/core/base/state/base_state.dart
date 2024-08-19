import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State {
  ThemeData get themeData => Theme.of(context);
}
