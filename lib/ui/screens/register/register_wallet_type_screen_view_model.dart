import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:ecoupon_lib/common/errors.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterWalletTypeScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletSource _walletSource;
  final IWalletService _walletService;

  RegisterWalletTypeScreenViewModel(
      this._router, this._walletSource, this._walletService);

  Future<void> privateWalletSelected() async {
    try {
      var currencies = await _walletSource.walletService.fetchCurrencies();
      var wallet =
          await _walletSource.walletService.createWallet(currencies[0]);
      await _walletService.setSelected(WalletEntity(wallet));
      await _router.pushNamed(RegisterVerifyRoute);
    } on HTTPError catch (e) {
      setViewState(Error(HTTPFailure(e.statusCode)));
    } on NotAuthenticatedError {
      setViewState(Error(NotAuthenticatedFailure()));
    }
  }

  Future<void> shopWalletSelected() async {
    try {
      var currencies = await _walletSource.walletService.fetchCurrencies();
      var wallet = await _walletSource.walletService
          .createWallet(currencies[0], isCompany: true);
      await _walletService.setSelected(WalletEntity(wallet));
      await _router.pushNamed(RegisterVerifyRoute);
    } on HTTPError catch (e) {
      setViewState(Error(HTTPFailure(e.statusCode)));
    } on NotAuthenticatedError {
      setViewState(Error(NotAuthenticatedFailure()));
    }
  }

  Future<void> back() {
    _router.pop();
    return Future.value();
  }
}
