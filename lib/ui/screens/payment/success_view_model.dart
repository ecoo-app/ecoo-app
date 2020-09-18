import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:injectable/injectable.dart';

class DurationEnd extends ViewState {}

@injectable
class SuccessViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletService _walletService;

  SuccessViewModel(this._router, this._walletService);

  Future<void> init(String nextRoute) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    await _walletService.updateSelected();
    await navigateNext(nextRoute);
  }

  Future<void> navigateNext(String route) {
    // can only be used if the route already exists... how to test? _router.popUntil(ModalRoute.withName(route));
    _router.pushAndRemoveUntil(route, '');
    return Future.value();
  }
}
