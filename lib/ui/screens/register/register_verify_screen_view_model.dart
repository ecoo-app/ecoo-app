import 'package:e_coupon/ui/core/router/router.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterVerifyScreenViewModel {
  final IRouter _router;

  RegisterVerifyScreenViewModel(this._router);

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
