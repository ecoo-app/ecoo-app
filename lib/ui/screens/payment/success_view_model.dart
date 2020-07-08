import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:injectable/injectable.dart';

class DurationEnd extends ViewState {}

@injectable
class SuccessViewModel extends BaseViewModel {
  // dont know how to make it work with a Duration object here directly....
  int duration = 1000;

  void init() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setViewState(DurationEnd());
    });
  }

// TODO how to set a custom duration?
  /// set duration if you want to use an other than the default duration of 1000 ms
  // void init({int durationInMS}) {
  //   if (durationInMS != null) {
  //     this.duration = durationInMS;
  //   }

  //   print(duration);

  //   // Future.delayed(duration, () {
  //   //   print('start delay');
  //   //   setViewState(DurationEnd());
  //   // });

  //   Future.delayed(const Duration(milliseconds: 1000), () {
  //     print('start delay');
  //     setViewState(DurationEnd());
  //   });
  // }
}
