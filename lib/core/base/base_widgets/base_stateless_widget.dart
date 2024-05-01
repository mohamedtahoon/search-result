import 'package:flutter/material.dart';
import 'package:search_task/core/base/base_utils/theme_mixin.dart';
import 'package:search_task/core/base/base_utils/translator_mixin.dart';

abstract class BaseStatelessWidget extends StatelessWidget
    with TranslatorMixin, ThemeMixin {
  @override
  Widget build(BuildContext context) {
    initTranslatorMixin(context);
    initThemeMixin(context);
    return baseBuild(context);
  }

  Widget baseBuild(BuildContext context);
}
