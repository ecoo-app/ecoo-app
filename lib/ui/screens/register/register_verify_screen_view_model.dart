import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterVerifyScreenViewModel {
  final IRouter _router;
  final IWalletService _walletService;

  RegisterVerifyScreenViewModel(this._router, this._walletService);

  bool get isShop => _walletService.getSelected()?.isShop ?? false;

  Future<void> close() {
    _router.pop();
    return Future.value();
  }

  Future<void> verify() async {
    await _router.pushNamed(VerificationRoute);
  }

  Future<void> verifyLater() async {
    await _router.pushAndRemoveUntil(WalletDetailRoute, '');
  }
}
