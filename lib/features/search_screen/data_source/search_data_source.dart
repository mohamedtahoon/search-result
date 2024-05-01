import 'package:search_task/core/api/api_keys.dart';
import 'package:search_task/core/base/network/network.dart';
import 'package:search_task/core/base/network/network_client.dart';
import 'package:search_task/features/search_screen/models/screen_result_request/screen_result_request.dart';
import 'package:search_task/features/search_screen/models/screen_result_response/screen_result_response.dart';

class SearchScreenResultDataSource {
  final Network _networkClient = Network(networkClient: NetworkClient());

  Future<ScreenResultResponse> getSearchResultData(
      ScreenResultRequest? screenResultRequest) async {
    Map<String, dynamic> response = await _networkClient
        .post(ApiKeys.apiIndividual, data: screenResultRequest?.toJson());
    return ScreenResultResponse.fromJson(response);
  }
}
