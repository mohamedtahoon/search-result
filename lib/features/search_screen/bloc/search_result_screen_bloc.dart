import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:search_task/core/design/colors_catalog.dart';
import 'package:search_task/features/search_screen/models/screen_result_request/screen_result_request.dart';
import 'package:search_task/features/search_screen/models/screen_result_response/screen_result_response.dart';
import 'package:search_task/features/search_screen/repo/search_screen_result_repo.dart';

part 'search_result_screen_event.dart';
part 'search_result_screen_state.dart';

class SearchResultScreenBloc
    extends Bloc<SearchResultScreenEvent, SearchResultScreenState> {
  final SearchScreenResultRepository _searchScreenResultRepository;
  SearchResultScreenBloc(this._searchScreenResultRepository)
      : super(SearchResultScreenInitialState());

  @override
  Stream<SearchResultScreenState> mapEventToState(
      SearchResultScreenEvent event) async* {
    if (event is SearchResultButtonEvent) {
      yield SearchResultScreenLoadingState();
      yield await _searchScreenResultRepository
          .getSearchResultData(event.screenResultRequest);
    } else if (event is SearchResultChangeListViewOrGridViewEvent) {
      yield SearchResultScreenLoadingState();
      yield SearchResultChangeListViewOrGridViewState();
    } else if (event is SearchResultShowButtonWidgetEvent) {
      yield SearchResultScreenLoadingState();
      yield SearchResultShowButtonWidgetState();
    } else if (event is SearchResultShowSearchBarEvent) {
      yield SearchResultScreenLoadingState();
      yield SearchResultShowSearchBarState();
    } else if (event is SearchResultHideSearchBarEvent) {
      yield SearchResultScreenLoadingState();
      yield SearchResultHideSearchBarState();
    } else if (event is SearchResultChangeThemeEvent) {
      yield SearchResultScreenLoadingState();
      yield SearchResultChangeThemeState(event.themeState);
    }
  }
}
