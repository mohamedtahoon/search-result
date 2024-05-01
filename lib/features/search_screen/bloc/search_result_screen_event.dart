part of 'search_result_screen_bloc.dart';

@immutable
abstract class SearchResultScreenEvent {}

class SearchResultButtonEvent extends SearchResultScreenEvent {
  final ScreenResultRequest screenResultRequest;
  SearchResultButtonEvent(this.screenResultRequest);
}

class SearchResultChangeListViewOrGridViewEvent
    extends SearchResultScreenEvent {
  SearchResultChangeListViewOrGridViewEvent();
}

class SearchResultShowButtonWidgetEvent extends SearchResultScreenEvent {
  SearchResultShowButtonWidgetEvent();
}

class SearchResultShowSearchBarEvent extends SearchResultScreenEvent {
  SearchResultShowSearchBarEvent();
}

class SearchResultHideSearchBarEvent extends SearchResultScreenEvent {}

class SearchResultChangeThemeEvent extends SearchResultScreenEvent {
  final ThemesStates themeState;
  SearchResultChangeThemeEvent(this.themeState);
}
