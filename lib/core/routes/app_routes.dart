import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_task/features/search_screen/bloc/search_result_screen_bloc.dart';
import 'package:search_task/features/search_screen/data_source/search_data_source.dart';
import 'package:search_task/features/search_screen/repo/search_screen_result_repo.dart';
import 'package:search_task/features/search_screen/ui/screens/search_result_screen.dart';

class AppRouter {
  AppRouter();
  final SearchScreenResultRepository _screenResultRepository =
      SearchScreenResultRepository(SearchScreenResultDataSource());

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SearchResultScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) =>
                    SearchResultScreenBloc(_screenResultRepository),
                child: const SearchResultScreen()));
    }
    return null;
  }
}
