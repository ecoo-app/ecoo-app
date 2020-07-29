import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:injectable/injectable.dart';

class DurationEnd extends ViewState {}

@injectable
class SuccessViewModel extends BaseViewModel {
  void init() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setViewState(DurationEnd());
    });
  }
}
