import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_task/core/base/lang/app_localization.dart';
import 'package:search_task/core/base/prefs/pref_manager.dart';

final Locale systemLocale = WidgetsBinding.instance.window.locales.first;

final Locale defaultSupportedLocale = AppLocalizations.supportedLocals.first;

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(defaultSupportedLocale) {
    getDefaultLanguage();
  }
  PrefManager prefManager = PrefManager();

  void getDefaultLanguage() async {
    Locale? locale;
    final savedLanguageCode = await getLanguageFromPreference();
    if (savedLanguageCode == null) {
      for (var localItem in AppLocalizations.supportedLocals) {
        if (localItem.languageCode == systemLocale.languageCode) {
          locale = systemLocale;
          break;
        } else {
          locale = defaultSupportedLocale;
        }
      }
    } else {
      locale = Locale(savedLanguageCode);
    }
    emit(locale!);
  }

  void changeLanguage(SupportLanguage selectedLanguage) async {
    final savedLanguageCode = await getLanguageFromPreference();
    if (selectedLanguage == SupportLanguage.arabicLang &&
        savedLanguageCode != arabicLangCode) {
      saveLanguageToPreference(arabicLangCode);
      emit(const Locale(arabicLangCode, arabicCountryCode));
    } else if (selectedLanguage == SupportLanguage.englishLang &&
        savedLanguageCode != englishLangCode) {
      saveLanguageToPreference(englishLangCode);
      emit(const Locale(englishLangCode, englishCountryCode));
    }
  }

  void saveLanguageToPreference(String languageCode) async {
    await prefManager.setLang(languageCode);
  }

  Future<String?> getLanguageFromPreference() async {
    return await prefManager.getLang();
  }
}

enum SupportLanguage { englishLang, arabicLang }
