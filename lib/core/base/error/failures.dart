import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure(String message) : super(message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(String message) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class NotCachedFailure extends Failure {
  const NotCachedFailure(String message) : super(message);
}

class ConflictFailure extends Failure {
  const ConflictFailure(String message) : super(message);
}

class RequestTimeoutFailure extends Failure {
  const RequestTimeoutFailure(String message) : super(message);
}

class UnProcessableEntityFailure extends Failure {
  const UnProcessableEntityFailure(String message) : super(message);
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure(String message) : super(message);
}

class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure(String message) : super(message);
}

class UnexpectedErrorFailure extends Failure {
  const UnexpectedErrorFailure(super.message);
}
