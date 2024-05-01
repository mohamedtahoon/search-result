import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:search_task/core/base/base_utils/enums/request_type_enum.dart';
import 'package:search_task/core/base/error/exceptions.dart';
import 'package:search_task/core/base/prefs/pref_manager.dart';

import 'network_client.dart';
import 'network_response.dart';

abstract class INetwork {
  Future<Map<String, dynamic>> post(String url,
      {dynamic data, Map<String, String>? headers});
}

class Network implements INetwork {
  INetworkClient networkClient;
  PrefManager prefManager = PrefManager();
  RetrialRequest? oldRequest;

  Network({required this.networkClient});

  void savePostRequest(String url, dynamic data) {
    oldRequest = null;
    oldRequest ??=
        RetrialRequest(method: RequestType.post, url: url, data: data);

    if (oldRequest != null) {
      if (oldRequest!.counter > 1) {
        oldRequest = null;
      }
    }
  }

  void disposeOldRequest() {
    oldRequest = null;
  }

  Future<Map<String, dynamic>> retryRequest() async {
    if (kDebugMode) {}

    if (oldRequest != null) {
      if (oldRequest!.method == RequestType.post) {
        return post(oldRequest!.url, data: oldRequest!.data);
      }
    }
    disposeOldRequest();
    throw const UnAuthorizedException({});
  }

  @override
  Future<Map<String, dynamic>> post(String url,
      {dynamic data, Map<String, String>? headers}) async {
    headers = await getHeaders();
    savePostRequest(url, data);
    final response = await networkClient.post(
      url,
      data: data,
      headers: headers,
    );
    return getResponse(response);
  }

  Future<Map<String, dynamic>> getResponse(NetworkResponse response) async {
    var responseData = response.data;

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        disposeOldRequest();
        return responseData;
      case 400:
      case 401:
      case 403:
        throw ServerException(response.data["message"]);
      case 404:
        throw NotFoundException(responseData);
      case 409:
        throw ConflictException(responseData);
      case 408:
        throw RequestTimeout(responseData);
      case 422:
        throw UnProcessableEntity(responseData);
      case 500:
        throw InternalServerError(responseData);
      case 503:
        throw ServiceUnavailable(responseData);
      default:
        throw UnexpectedError();
    }
  }
}

getHeaders() async {
  Map<String, String> headers = {};
  headers.addAll({
    "Content-Type": "application/json",
    "accept": "application/json",
  });
  return headers;
}

class RetrialRequest extends Equatable {
  int counter = 0;
  final RequestType method;
  final String url;
  final dynamic data;
  final Map<String, String>? queryParams;
  RetrialRequest({
    required this.method,
    required this.url,
    this.data,
    this.queryParams,
  }) {
    counter++;
  }

  @override
  List<Object?> get props => [counter, method, url, data, queryParams];
}
