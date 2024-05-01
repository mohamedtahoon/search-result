import 'package:dio/dio.dart';
import 'package:search_task/core/api/api_keys.dart';
import 'package:search_task/core/base/error/exceptions.dart';

import 'network_response.dart';

abstract class INetworkClient {
  Future<NetworkResponse> post(String url,
      {Map<String, dynamic>? headers, dynamic data});
}

class NetworkClient implements INetworkClient {
  final Dio dio = Dio();

  NetworkClient() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiKeys.baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    );
    dio.options = options;
  }
  NetworkResponse getNetworkResponse(Response response) {
    return NetworkResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<NetworkResponse> post(String url,
      {Map<String, dynamic>? headers, dynamic data}) async {
    try {
      dio.options.headers.addAll(headers!);
      final response = await dio.post(
        url,
        options: Options(
          responseType: ResponseType.json,
          headers: headers,
        ),
        data: data,
      );

      return getNetworkResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw UnexpectedError();
      }

      throw const ServerException("check your internet connections");
    }
  }
}
