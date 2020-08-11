import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterWalletTypeScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletService _walletService;
  final IWalletRepo _walletRepo;

  RegisterWalletTypeScreenViewModel(
      this._router, this._walletService, this._walletRepo);

  Future<void> privateWalletSelected() async {
    await _onWalletTypeSelected(isTypeShop: false);
    // try {
    //   var currencies = await _walletSource.walletService.fetchCurrencies();
    //   var wallet =
    //       await _walletSource.walletService.createWallet(currencies[0]);
    //   await _walletService.setSelected(WalletEntity(wallet));
    //   await _router.pushNamed(RegisterVerifyRoute);
    // } on HTTPError catch (e) {
    //   setViewState(Error(HTTPFailure(e.statusCode)));
    // } on NotAuthenticatedError {
    //   setViewState(Error(NotAuthenticatedFailure()));
    // }
  }

  Future<void> shopWalletSelected() async {
    await _onWalletTypeSelected(isTypeShop: true);
  }

  Future<void> _onWalletTypeSelected({bool isTypeShop}) async {
    var walletOrFailure =
        await _walletRepo.createWallet(null, isShop: isTypeShop);

    walletOrFailure.fold((failure) {
      setViewState(Error(failure));
    }, (wallet) {
      _onWalletCreated(WalletEntity(wallet));
    });
  }

  Future<void> _onWalletCreated(WalletEntity wallet) async {
    await _walletService.setSelected(wallet);
    await _router.pushNamed(RegisterVerifyRoute);
  }

  Future<void> back() {
    _router.pop();
    return Future.value();
  }
}
