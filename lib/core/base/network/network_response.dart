import 'package:equatable/equatable.dart';

class NetworkResponse<T> extends Equatable {
  T? data;
  int? statusCode;

  NetworkResponse({
    this.data,
    this.statusCode,
  });

  NetworkResponse<T> copyWith({
    T? data,
    int? statusCode,
  }) {
    return NetworkResponse<T>(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [data, statusCode];
}
