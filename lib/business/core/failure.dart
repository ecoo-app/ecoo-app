import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

class Excep extends Failure {
  final message;

  Excep(this.message);

  @override
  List<Object> get props => [message];
}

class NoService extends Failure {
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
