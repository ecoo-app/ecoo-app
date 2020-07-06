enum ViewStateEnum { Idle, Busy }

abstract class ViewState {}

class Initial extends ViewState {}

class Loading extends ViewState {}

class Success<T> extends ViewState {
  final T result;

  Success(this.result);
}

class Error extends ViewState {
  final String messageId; // i18n message id

  Error(this.messageId);
}
