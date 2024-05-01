import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_task/core/base/base_widgets/base_stateful_widget.dart';
import 'package:search_task/core/design/assets_catalog.dart';
import 'package:search_task/core/design/colors_catalog.dart';
import 'package:search_task/features/search_screen/ui/screens/search_result_screen.dart';

class SplashScreen extends BaseStatefulWidget {
  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// to start time to switch to another screen
    startTime();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: ColorsCatalog().APP_LINEAR_GRADIENT,
      ),
      child: Center(
          child: SvgPicture.asset(
        AssetCatalog.splashPage,
        height: 100.h,
        width: 100.w,
        color: ColorsCatalog().APP_WHITE,
      )),
    );
  }

  /// time to switch to home screen
  startTime() {
    var duration = const Duration(milliseconds: 1700);
    return Timer(duration, navigationPage);
  }

  /// navigate to home screen
  Future<void> navigationPage() async {
    Navigator.of(context).pushReplacementNamed(SearchResultScreen.routeName);
  }
}
