import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/transfer_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class QRBillViewModel extends BaseViewModel {
  final IWalletService _walletService;
  final ITransferService _transferService;
  final IRouter _router;

  QRBillViewModel(this._transferService, this._router, this._walletService);

  bool get isShop => this._walletService.getSelected().isShop;
  Transfer get transferData => this._transferService.transfer;

  String get qrImageDate {
    return "destination:${transferData.reciever.id},amount:${transferData.reciever.amount}";
  }

  // TODO wait for push
  // TODO success text
  void onSuccess() {
    _router.pushNamed(SuccessRoute,
        arguments: SuccessScreenArguments(
            isShop: isShop,
            text: 'Transaktion erfolgreich',
            iconAssetPath: Assets.cash_register_svg));
  }
}
