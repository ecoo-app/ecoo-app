import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:flutter/widgets.dart';

// TODO replace viewStateEnum with ViewState
class BaseViewModel extends ChangeNotifier {
  // deprecated use ViewState!
  ViewStateEnum _state = ViewStateEnum.Busy;
  ViewState _viewState = Initial();

  ViewStateEnum get state => _state;
  ViewState get viewState => _viewState;

  void setState(ViewStateEnum viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }
}
