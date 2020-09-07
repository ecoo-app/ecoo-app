import 'package:ecoupon_lib/common/errors.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

class MessageFailure extends Failure {
  final message;

  MessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class NoService extends Failure {
  @override
  List<Object> get props => [];
}

class HTTPFailure extends Failure {
  final int code;
  final Map<String, List<String>> response;

  HTTPFailure(this.code, this.response);

  factory HTTPFailure.from(HTTPError other) {
    return HTTPFailure(other.statusCode, other.details);
  }

  @override
  List<Object> get props => [code];
}

class NotAuthenticatedFailure extends Failure {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UnknownFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NoTransactionPossibleFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NoPinSetFailure extends Failure {
  @override
  List<Object> get props => [];
}
