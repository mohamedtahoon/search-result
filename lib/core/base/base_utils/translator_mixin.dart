import 'package:flutter/material.dart';
import 'package:search_task/core/base/lang/app_localization.dart';

mixin TranslatorMixin {
  AppLocalizations? appLocal;

  void initTranslatorMixin(BuildContext context) {
    appLocal = AppLocalizations.of(context);
  }

  String translate(String key) {
    return appLocal?.translate(key) ?? "";
  }

  bool isRTL() {
    return appLocal?.isRTL() ?? false;
  }

  bool isLTR() {
    return appLocal?.isLTR() ?? false;
  }
}
