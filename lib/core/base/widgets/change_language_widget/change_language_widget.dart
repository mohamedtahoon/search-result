import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_task/core/base/base_lang_cubit/language_cubit.dart';
import 'package:search_task/core/base/base_widgets/base_stateless_widget.dart';
import 'package:search_task/core/base/lang/app_localization.dart';
import 'package:search_task/core/base/lang/app_localization_keys.dart';

class ChangeLanguageWidget extends BaseStatelessWidget {
  @override
  Widget baseBuild(BuildContext context) {
    final LanguageCubit languageCubit = BlocProvider.of<LanguageCubit>(context);

    return TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsetsDirectional.only(end: 15))),
      child: Text(translate(LangKeys.languageChange)),
      onPressed: () => applyChangeLanguage(languageCubit),
    );
  }

  void applyChangeLanguage(LanguageCubit langCubit) {
    if (appLocal?.locale.languageCode == englishLangCode) {
      langCubit.changeLanguage(SupportLanguage.arabicLang);
    } else {
      langCubit.changeLanguage(SupportLanguage.englishLang);
    }
  }
}
