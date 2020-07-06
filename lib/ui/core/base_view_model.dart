import 'package:e_coupon/ui/core/viewstate.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  ViewStateEnum _state = ViewStateEnum.Busy;

  ViewStateEnum get state => _state;

  void setState(ViewStateEnum viewState) {
    _state = viewState;
    notifyListeners();
  }
}
