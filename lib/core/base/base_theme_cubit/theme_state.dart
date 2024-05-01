import 'package:equatable/equatable.dart';
import 'package:search_task/core/design/colors_catalog.dart';

class ThemeState extends Equatable {
  final ThemesStates themesStates;

  const ThemeState(this.themesStates);

  @override
  List<Object> get props => [themesStates];
}
