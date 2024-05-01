import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_task/core/base/base_theme_cubit/theme_state.dart';
import 'package:search_task/core/design/colors_catalog.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemesStates.mainLayout));

  void toggleTheme(ThemesStates themesStates) {
    if (themesStates == ThemesStates.mainLayout) {
      emit(const ThemeState(ThemesStates.mainLayout));
      ColorsCatalog.isBlueLayout = false;
      ColorsCatalog.isGreenLayout = false;
      ColorsCatalog.isDarkLayout = false;
    } else if (themesStates == ThemesStates.blueLayout) {
      emit(const ThemeState(ThemesStates.blueLayout));
      ColorsCatalog.isLightMode = false;
      ColorsCatalog.isGreenLayout = false;
      ColorsCatalog.isDarkLayout = false;
    } else if (themesStates == ThemesStates.greenLayout) {
      emit(const ThemeState(ThemesStates.greenLayout));
      ColorsCatalog.isLightMode = false;
      ColorsCatalog.isBlueLayout = false;
      ColorsCatalog.isDarkLayout = false;
    } else {
      emit(const ThemeState(ThemesStates.darkModeLayout));
      ColorsCatalog.isLightMode = false;
      ColorsCatalog.isBlueLayout = false;
      ColorsCatalog.isGreenLayout = false;
    }
  }
}
