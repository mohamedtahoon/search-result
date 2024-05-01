import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_task/core/base/base_lang_cubit/language_cubit.dart';
import 'package:search_task/core/base/base_theme_cubit/theme_cubit.dart';
import 'package:search_task/core/base/base_theme_cubit/theme_state.dart';
import 'package:search_task/core/base/lang/app_localization.dart';
import 'package:search_task/core/design/colors_catalog.dart';
import 'package:search_task/core/routes/app_routes.dart';
import 'package:search_task/features/splash_screen/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(439, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MultiBlocProvider(
              providers: [
                BlocProvider<LanguageCubit>(
                    create: (BuildContext context) => LanguageCubit()),
                BlocProvider<ThemeCubit>(
                    create: (BuildContext context) => ThemeCubit()),
              ],
              child: BlocBuilder<LanguageCubit, Locale>(
                  builder: (context, localeState) {
                return BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, themeState) {
                  return MaterialApp(
                      title: 'Search Task',
                      theme: ColorsCatalog()
                          .getTheme(themesStates: themeState.themesStates),
                      debugShowCheckedModeBanner: false,
                      supportedLocales: AppLocalizations.supportedLocals,

                      /// these delegates make sure that
                      ///     the localization data for the proper
                      /// language is loaded ...
                      localizationsDelegates: const [
                        /// A class which loads the translations from JSON files
                        AppLocalizations.delegate,

                        /// Built-in localization of basic text for Material widgets
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,

                        /// Built-in localization for text direction LTR/RTL
                        GlobalWidgetsLocalizations.delegate,

                        GlobalCupertinoLocalizations.delegate,
                      ],
                      locale: localeState,
                      home: SplashScreen(),
                      onGenerateRoute: AppRouter().generateRoute);
                });
              }),
            ));
  }
}
