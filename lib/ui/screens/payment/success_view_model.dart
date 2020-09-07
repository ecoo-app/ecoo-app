import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:injectable/injectable.dart';

class DurationEnd extends ViewState {}

@injectable
class SuccessViewModel extends BaseViewModel {
  final IRouter _router;

  SuccessViewModel(this._router);

  Future<void> init(String nextRoute) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    await navigateNext(nextRoute);
  }

  Future<void> navigateNext(String route) {
    _router.pushAndRemoveUntil(route, '');
    return Future.value();
  }
}
