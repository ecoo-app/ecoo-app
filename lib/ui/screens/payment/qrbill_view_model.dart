import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/transfer_service.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@injectable
class QRBillViewModel extends BaseViewModel {
  final IWalletService _walletService;
  final ITransferService _transferService;
  final IRouter _router;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  QRBillViewModel(this._transferService, this._router, this._walletService);

  bool get isShop => this._walletService.getSelected().isShop;
  Transfer get transferData => this._transferService.transfer;

  void init() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // onMessage: {notification: {title: Test notification, body: Test single notification}, data: {}}
        print("onMessage: $message");
        await _router.pushNamed(SuccessRoute,
            arguments: SuccessScreenArguments(
                text: 'Transaktion erfolgreich',
                iconAssetPath:
                    isShop ? Assets.cash_register_svg : Assets.check_double_svg,
                isShop: isShop));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  String get qrImageData {
    return Utils.qrData(
        destinationId: transferData.destWalletId, amount: transferData.amount);
  }

  void onPaperWalletScan() {
    _router.pushNamed(QRScanRoute, arguments: false);
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
