import 'package:e_coupon/business/core/failure.dart';

// depracated use ViewState classes instead
enum ViewStateEnum { Idle, Busy }

// TODO use this
abstract class ViewState {}

class Empty extends ViewState {}

class Initial extends ViewState {}

class Loading extends ViewState {}

class Loaded extends ViewState {}

class Success<T> extends ViewState {
  final T result;

  Success(this.result);
}

class Error<T extends Failure> extends ViewState {
  final T failure;

  Error(this.failure);
}

class Update extends ViewState {}
