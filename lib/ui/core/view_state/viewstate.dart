import 'package:e_coupon/core/failure.dart';

enum ViewStateEnum { Idle, Busy }

// TODO use this
abstract class ViewState {}

class Initial extends ViewState {}

class Loading extends ViewState {}

class Success<T> extends ViewState {
  final T result;

  Success(this.result);
}

class Error<T extends Failure> extends ViewState {
  final T messageId;

  Error(this.messageId);
}
