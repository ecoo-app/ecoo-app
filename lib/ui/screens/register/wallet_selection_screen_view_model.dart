import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

@injectable
class WalletSelectionScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletService _walletService;
  final IWalletRepo _walletRepo;

  WalletSelectionScreenViewModel(
      this._router, this._walletService, this._walletRepo);

  Future<void> privateWalletSelected() async {
    await _onWalletTypeSelected(isTypeShop: false);
  }

  Future<void> shopWalletSelected() async {
    await _onWalletTypeSelected(isTypeShop: true);
  }

  Future<void> _onWalletTypeSelected({bool isTypeShop}) async {
    setViewState(Loading());

    // Return to Loaded State in case the user cancels the Pin dialog of the Device.
    // We do not get any callback if the user cancels that process
    unawaited(Future.delayed(Duration(milliseconds: 1000)).then((value) {
      setViewState(Loaded());
    }));

    var walletOrFailure =
        await _walletRepo.createWallet(null, isShop: isTypeShop);
    await walletOrFailure.fold((failure) {
      setViewState(Error(failure));
    }, (wallet) async {
      await _onWalletCreated(WalletEntity(wallet));
      setViewState(Success(''));
    });
    // setViewState(Loaded());
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
