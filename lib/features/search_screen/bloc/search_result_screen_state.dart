part of 'search_result_screen_bloc.dart';

@immutable
abstract class SearchResultScreenState {}

class SearchResultScreenInitialState extends SearchResultScreenState {}

class SearchResultScreenLoadingState extends SearchResultScreenState {}

class SearchResultScreenErrorState extends SearchResultScreenState {
  final String message;
  SearchResultScreenErrorState(this.message);
}

class SearchResultScreenNetworkErrorState extends SearchResultScreenState {
  final String message;
  SearchResultScreenNetworkErrorState(this.message);
}

class SearchResultScreenGetDataSuccessState extends SearchResultScreenState {
  final ScreenResultResponse? screenResultResponse;
  SearchResultScreenGetDataSuccessState(this.screenResultResponse);
}

class SearchResultChangeListViewOrGridViewState
    extends SearchResultScreenState {
  SearchResultChangeListViewOrGridViewState();
}

class SearchResultShowButtonWidgetState extends SearchResultScreenState {}

class SearchResultShowSearchBarState extends SearchResultScreenState {}

class SearchResultHideSearchBarState extends SearchResultScreenState {}

class SearchResultChangeThemeState extends SearchResultScreenState {
  final ThemesStates themeState;
  SearchResultChangeThemeState(this.themeState);
}
