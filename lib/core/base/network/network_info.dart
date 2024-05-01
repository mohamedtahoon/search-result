import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:search_task/core/base/error/failures.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
  Future<Either<Failure, T>> ifConnectedOrReturnFailure<T>(
      Future<Either<Failure, T>> Function() fun);

  Future<Either<Failure, T>> isConnectedToServer<T>(
      Future<Either<Failure, T>> Function() fun1,
      Future<Either<Failure, T>> Function() fun2);
}

class NetworkInfo implements INetworkInfo {
  final Connectivity? con;
  NetworkInfo({this.con});

  @override
  Future<bool> get isConnected async {
    Completer<bool> completer = Completer<bool>();
    StreamSubscription<ConnectivityResult>? subscription;
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
      subscription?.cancel();
    });
    return completer.future;
  }

  @override
  Future<Either<Failure, T>> ifConnectedOrReturnFailure<T>(
      Future<Either<Failure, T>> Function() fun) async {
    if (await isConnected) {
      return fun();
    } else {
      return const Left(NetworkFailure("NetworkFailure"));
    }
  }

  @override
  Future<Either<Failure, T>> isConnectedToServer<T>(
      Future<Either<Failure, T>> Function() fun1,
      Future<Either<Failure, T>> Function() fun2) async {
    if (await isConnected) {
      return fun1();
    } else {
      return fun2();
    }
  }
}
