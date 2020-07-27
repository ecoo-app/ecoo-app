import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterWalletTypeScreenViewModel extends BaseViewModel {
  final IRouter _router;

  RegisterWalletTypeScreenViewModel(this._router);

  Future<void> privateWalletSelected() async {
    await _router.pushNamed(RegisterVerifyRoute);
  }

  Future<void> shopWalletSelected() async {
    await _router.pushNamed(RegisterVerifyRoute);
  }

  Future<void> back() {
    _router.pop();
    return Future.value();
  }
}
