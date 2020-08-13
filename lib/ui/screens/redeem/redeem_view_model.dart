import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class RedeemViewModel extends BaseViewModel {
  final IWalletService _walletService;
  final IWalletSource _walletSource;
  final IRouter _router;
  WalletEntity wallet;
  String nameOfBank;
  String iban;
  String owner;

  RedeemViewModel(this._walletService, this._router, this._walletSource);

  void init() {
    wallet = _walletService.getSelected();
  }

  void onRedeem(String successText) async {
    setViewState(Loading());

    try {
      var transaction = await _walletSource.walletService.transfer(
          wallet.walletModel,
          wallet.currency.currencyModel.owner,
          wallet.amount);
      var cashOut =
          await _walletSource.walletService.cashOut(transaction, owner, iban);

      if (cashOut != null) {
        await _router.pushNamed(SuccessRoute,
            arguments: SuccessScreenArguments(
              isShop: true,
              text: successText,
              iconAssetPath: Assets.envelope_open_dollar_svg,
              nextRoute: WalletDetailRoute,
            ));
      }
    } catch (e) {
      setViewState(Error(MessageFailure(e.toString())));
    }

    setViewState(Loaded());
  }
}
