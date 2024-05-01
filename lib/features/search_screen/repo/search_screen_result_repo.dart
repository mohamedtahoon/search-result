import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:search_task/core/base/base_repo/base_repo.dart';
import 'package:search_task/core/base/network/network_info.dart';
import 'package:search_task/features/search_screen/bloc/search_result_screen_bloc.dart';
import 'package:search_task/features/search_screen/data_source/search_data_source.dart';
import 'package:search_task/features/search_screen/models/screen_result_request/screen_result_request.dart';

class SearchScreenResultRepository extends BaseRepository {
  late SearchScreenResultDataSource dataSource;

  SearchScreenResultRepository(
      SearchScreenResultDataSource searchScreenResultDataSource)
      : super(NetworkInfo(con: Connectivity())) {
    dataSource = searchScreenResultDataSource;
  }

  Future<SearchResultScreenState> getSearchResultData(
      ScreenResultRequest screenResultRequest) async {
    SearchResultScreenState searchResultScreenState =
        SearchResultScreenInitialState();
    var res = await handleException(() async => dataSource.getSearchResultData(
        ScreenResultRequest(
            firstName: screenResultRequest.firstName,
            middleName: screenResultRequest.middleName,
            nationality: screenResultRequest.nationality)));
    res.fold(
        (failure) => {
              searchResultScreenState =
                  SearchResultScreenNetworkErrorState(failure.message)
            },
        (response) => {
              if (response.screenResult!.isNotEmpty)
                {
                  searchResultScreenState =
                      SearchResultScreenGetDataSuccessState(response)
                }
              else
                {
                  searchResultScreenState =
                      SearchResultScreenErrorState("try again ..")
                }
            });
    return searchResultScreenState;
  }
}
