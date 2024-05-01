import 'dart:math';

import 'package:flutter/material.dart';

class ColorsCatalog {
  static final ColorsCatalog _instance = ColorsCatalog._internal();

  factory ColorsCatalog() {
    return _instance;
  }

  ColorsCatalog._internal();

  static bool isLightMode = false;
  static bool isBlueLayout = false;
  static bool isGreenLayout = false;
  static bool isDarkLayout = false;
  //Main Colors
  static const _APP_BLUE = Color(0xff2669AE);
  static const _APP_GREEN = Color(0xff009048);
  static const _APP_WHITE = Color(0xffFFFFFF);

  //Secondary Colors
  static const _APP_RED = Color(0xffDC3F3C);
  static const _APP_GOLD = Color(0xffF8AC20);
  static const _APP_SKY_BLUE = Color(0xff36ADE1);
  static const _APP_GREY = Color(0xffDEDEDE);
  static const _APP_DARK_GREY = Color(0xff1A1A1A);
  static const _APP_WHITE_50 = Color(0x80FFFFFF);
  static const _APP_LIGHT_GREY = Color(0xFFF8F8F8);
  static const _APP_DARK_BLUE = Color(0xff194571);
  static const _APP_DARK_GREEN = Color(0xff72C18B);
  static const _APP_DARK_MODE_MAIN_COLOR = Color(0xff1F2023);
  static const _APP_DISABELED_COLOR = Color(0xFF9E9E9E);
  static const _APP_SECONDARY_COLOR = Color(0xFF333333);
  static const _APP_TRASPARENT = Colors.transparent;
  static const _APP_GREY_LABEL = Color(0xFFDDDDDD);
  static const _APP_BLACK = Colors.black;
  static const _APP_DARK_MODE_GRADIENT = Color(0xFF242424);

  //Main Colors getters
  Color get APP_BLUE {
    return _APP_BLUE;
  }

  Color get APP_GREEN {
    return _APP_GREEN;
  }

  Color get APP_WHITE {
    return _APP_WHITE;
  }

  Color get APP_RED {
    return _APP_RED;
  }

  Color get APP_GOLD {
    return _APP_GOLD;
  }

  Color get APP_SKY_BLUE {
    return _APP_SKY_BLUE;
  }

  Color get APP_GREY {
    return _APP_GREY;
  }

  Color get APP_DARK_GREY {
    return _APP_DARK_GREY;
  }

  Color get APP_WHITE_50 {
    return _APP_WHITE_50;
  }

  Color get APP_LIGHT_GREY {
    return _APP_LIGHT_GREY;
  }

  Color get APP_DARK_BLUE {
    return _APP_DARK_BLUE;
  }

  Color get APP_DARK_GREEN {
    return isBlueLayout
        ? APP_DARK_BLUE
        : isGreenLayout
            ? _APP_DARK_GREEN
            : isDarkLayout
                ? _APP_DARK_MODE_GRADIENT
                : APP_GREEN;
  }

  Color get APP_DARK_MODE_MAIN_COLOR {
    return _APP_DARK_MODE_MAIN_COLOR;
  }

  Color get APP_TRANSPARENT {
    return _APP_TRASPARENT;
  }

  Color get APP_BLACK {
    return _APP_BLACK;
  }

  Color get APP_DISABELED_COLOR {
    return _APP_DISABELED_COLOR;
  }

  Color get APP_GREY_LABEL {
    return _APP_GREY_LABEL;
  }

  Color get APP_SECONDARY_COLOR {
    return _APP_SECONDARY_COLOR;
  }

  //Gradients
  LinearGradient get APP_LINEAR_GRADIENT => LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: isBlueLayout
          ? [APP_DARK_BLUE, APP_DARK_BLUE]
          : isGreenLayout
              ? [_APP_GREEN, _APP_GREEN]
              : isDarkLayout
                  ? [_APP_DARK_MODE_GRADIENT, _APP_DARK_MODE_GRADIENT]
                  : [APP_GREEN, APP_BLUE]);

  MaterialColor generateMaterialColors(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  ThemeData get themeDataLight {
    return ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      brightness: Brightness.light,
    );
  }

  getTheme({ThemesStates? themesStates}) {
    switch (themesStates) {
      case ThemesStates.mainLayout:
        isLightMode = true;
        return themeDataLight;
      case ThemesStates.blueLayout:
        isBlueLayout = true;
        return themeDataLight;
      case ThemesStates.greenLayout:
        isGreenLayout = true;
        return themeDataLight;
      case ThemesStates.darkModeLayout:
        isDarkLayout = true;
        return themeDataLight;
      default:
        return themeDataLight;
    }
  }
}

enum ThemesStates { mainLayout, blueLayout, greenLayout, darkModeLayout }
