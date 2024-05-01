import 'package:dartz/dartz.dart';
import 'package:search_task/core/base/error/exceptions.dart';
import 'package:search_task/core/base/error/failures.dart';
import 'package:search_task/core/base/network/network_info.dart';

abstract class BaseRepository {
  INetworkInfo networkInfo;

  BaseRepository(
    this.networkInfo,
  );

  Future<Either<Failure, T>> handleGeneralException<T>(
      Future<T> Function() fun) async {
    return networkInfo.ifConnectedOrReturnFailure<T>(
      () async {
        return handleException(fun);
      },
    );
  }

  Future<Either<Failure, T>> callDataSourceWithNoInternetCheck<T>(
      Future<T> Function() fun) async {
    return handleException(fun);
  }

  Future<Either<Failure, T>> repoCaching<T>(
      Future<T> Function() fun1, Future<T> Function() fun2) async {
    return networkInfo.isConnectedToServer(() {
      return handleException(fun1);
    }, () {
      return handleException(fun2);
    });
  }

  Future<Either<Failure, T>> handleException<T>(
      Future<T> Function() fun) async {
    try {
      return Right(await fun());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on UnAuthorizedException {
      return const Left(UnAuthorizedFailure("UnAuthorizedFailure"));
    } on NotFoundException {
      return const Left(NotFoundFailure("ServiceNotFound"));
    } on NetworkException {
      return const Left(NetworkFailure("NetworkFailure"));
    } on ValidationException {
      return const Left(ValidationFailure("ValidationFailure"));
    } on NotCachedException {
      return const Left(NotCachedFailure("NotCachedFailure"));
    } on ConflictException {
      return const Left(ConflictFailure("ConflictFailure"));
    } on RequestTimeout {
      return const Left(RequestTimeoutFailure("RequestTimeoutFailure"));
    } on UnProcessableEntity {
      return const Left(UnProcessableEntityFailure("RequestTimeoutFailure"));
    } on InternalServerError {
      return const Left(
          InternalServerErrorFailure("InternalServerErrorFailure"));
    } on ServiceUnavailable {
      return const Left(ServiceUnavailableFailure("ServiceUnavailableFailure"));
    } on UnexpectedError {
      return const Left(UnexpectedErrorFailure("UnexpectedErrorFailure"));
    } catch (e) {
      return const Left(GeneralFailure("GeneralFailure"));
    }
  }
}
