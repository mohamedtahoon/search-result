import 'package:flutter/material.dart';
import 'package:search_task/core/base/base_utils/loading_manager_mixin.dart';
import 'package:search_task/core/base/base_utils/theme_mixin.dart';
import 'package:search_task/core/base/base_utils/translator_mixin.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({
    Key? key,
  }) : super(key: key);

  @override
  BaseState createState() {
    return baseCreateState();
  }

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with TranslatorMixin, ThemeMixin, LoadingManagerMixin {
  @override
  Widget build(BuildContext context) {
    initTranslatorMixin(context);
    initThemeMixin(context);
    return baseWidget();
  }

  Widget baseWidget() {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [baseBuild(context), loadingManagerWidget()],
      ),
    );
  }

  void changeState() {
    setState(() {});
  }

  @override
  void runChangeState() {
    changeState();
  }

  @override
  BaseState provideTranslate() {
    return this;
  }

  Widget baseBuild(BuildContext context);
}
