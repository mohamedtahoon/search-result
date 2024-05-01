import 'package:flutter/material.dart';

mixin ThemeMixin {
  ThemeData? themeData;
  TextTheme? textTheme;

  void initThemeMixin(BuildContext context) {
    themeData = Theme.of(context);
    textTheme = themeData?.textTheme;
  }

  Color? primaryColor() => themeData?.primaryColor;
}
