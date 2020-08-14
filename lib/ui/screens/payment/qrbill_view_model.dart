import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/notification_service.dart';
import 'package:e_coupon/ui/core/services/transfer_service.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class QRBillViewModel extends BaseViewModel
    implements ITransferNotificationListener {
  final IWalletService _walletService;
  final ITransferService _transferService;
  final IRouter _router;
  final INotificationService _notificationService;
  bool wasNotified = false;

  QRBillViewModel(this._transferService, this._router, this._walletService,
      this._notificationService);

  bool get isShop => this._walletService.getSelected().isShop;
  Transfer get transferData => this._transferService.transfer;

  void init() {
    _notificationService.setTransferNotificationListener(this);
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     // onMessage: {notification: {title: eCoupon, body: You have received 0.01 CHF from DJ888240}, data: {}}
    //     print("onMessage: $message");
    //     if (_router.isCurrentRouteQRBillRoute()) {
    //       if (onSuccess != null) {
    //         await onSuccess();
    //       }
    //     }
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
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
    _transferService.reset();
    _router.pushNamed(SuccessRoute,
        arguments: SuccessScreenArguments(
          isShop: isShop,
          text: 'Transaktion erfolgreich',
          iconAssetPath: Assets.cash_register_svg,
          nextRoute: WalletDetailRoute,
        ));
  }

  @override
  void onTransfer() {
    if (!wasNotified) {
      wasNotified = true;
      _notificationService.removeTransfertNotificationListener();
      onSuccess();
    }
  }
}
