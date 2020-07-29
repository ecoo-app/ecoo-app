import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

// TODO replace viewStateEnum with ViewState
class BaseViewModel extends ChangeNotifier {
  // _state deprecated use ViewState!
  ViewStateEnum _state = ViewStateEnum.Busy;
  ViewState _viewState = Initial();

  ViewStateEnum get state => _state;
  ViewState get viewState => _viewState;

  void setState(ViewStateEnum viewState) {
    _state = viewState;
    // notifyListeners();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setViewState(ViewState viewState) {
    _viewState = viewState;
    // notifyListeners();
    // if this is used success screen functionality does not work anymore ??
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      notifyListeners();
    });
  }
}
