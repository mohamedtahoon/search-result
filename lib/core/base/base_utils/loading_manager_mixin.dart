import 'package:flutter/material.dart';
import 'package:search_task/core/base/base_utils/translator_mixin.dart';
import 'package:search_task/core/base/lang/app_localization_keys.dart';
import 'package:search_task/core/base/widgets/custom_widgets/full_screen_loader_widget.dart';

mixin LoadingManagerMixin {
  void runChangeState();

  TranslatorMixin provideTranslate();

  String? message;
  bool isLoading = false;
  bool isLoadingWithMessage = false;

  void showLoading() async {
    if (!isLoading) {
      isLoading = true;
      runChangeState();
    }
  }

  void hideLoading() async {
    if (isLoading) {
      isLoading = false;
      runChangeState();
    }
  }

  void showMessageLoading({String? message}) async {
    this.message = message ?? plzWaitMsg();
    if (!isLoadingWithMessage) {
      isLoadingWithMessage = true;
      runChangeState();
    }
  }

  void hideMessageLoading() async {
    if (isLoadingWithMessage) {
      isLoadingWithMessage = false;
      runChangeState();
    }
  }

  Widget loadingManagerWidget() {
    if (isLoading) {
      return customLoadingWidget();
    } else if (isLoadingWithMessage) {
      return customLoadingMessageWidget(message ?? "");
    } else {
      return getEmptyWidget();
    }
  }

  /// use this method if you want to change the default loading widget
  Widget customLoadingWidget() {
    return FullScreenLoaderWidget.onlyAnimation();
  }

  /// use this method if you want to change the default loading widget with
  /// it's message
  /// [message] --> refer to the message that you want to display
  /// that already submitted using [showMessageLoading]
  Widget customLoadingMessageWidget(String message) {
    return FullScreenLoaderWidget.message(message);
  }

  String? plzWaitMsg() => provideTranslate().translate(LangKeys.plzWait);
}

Widget getEmptyWidget() {
  return const SizedBox.shrink();
}
