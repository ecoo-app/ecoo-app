import 'package:e_coupon/business/entities/wallet.dart';
import 'package:ecoupon_lib/models/currency.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib;

import 'mock_library.dart';

class MockEncashmentTag extends TagAPI {
  MockEncashmentTag() : super(id: 'isEncashment', label: 'isEncashment');
}

List<Transaction> MockTransactionWalletPrivate = [
  Transaction('Wallet-ID ertl34u53', 'to', 1250, TransactionState.done,
      DateTime.now(), 'some tag'),
  Transaction('Wallet-ID sdfsdfwet', 'to', -2000, TransactionState.done,
      DateTime.now().subtract(Duration(days: 5)), 'some tag'),
  Transaction('Wallet-ID 345fdget5', 'to', 1100, TransactionState.failed,
      DateTime.now().subtract(Duration(days: 5)), 'some tag'),
  Transaction('Wallet-ID erfgb4545', 'to', -450, TransactionState.open,
      DateTime.now().subtract(Duration(days: 2)), 'some tag'),
  Transaction('Wallet-ID 3w45g5467', 'to', 1360, TransactionState.pending,
      DateTime.now().subtract(Duration(days: 2)), 'some tag'),
];

List<Transaction> MockTransactionWalletShop = [
  Transaction('Wallet-ID ertl34u53', 'to', 1250, TransactionState.done,
      DateTime.now(), 'some tag'),
  Transaction('Wallet-ID sdfsdfwet', 'to', 2000, TransactionState.done,
      DateTime.now(), 'some tag'),
  Transaction('Wallet-ID 345fdget5', 'to', 1100, TransactionState.pending,
      DateTime.now().subtract(Duration(days: 2)), 'some tag'),
  Transaction('Wallet-ID erfgb4545', 'to', -450, TransactionState.failed,
      DateTime.now().subtract(Duration(days: 2)), 'some tag'),
  Transaction('Wallet-ID sdfrtert4', 'to', -450, TransactionState.open,
      DateTime.now().subtract(Duration(days: 1)), 'some tag'),
  Transaction('Wallet-ID 3w45g5467', 'to', 1360, TransactionState.done,
      DateTime.now().subtract(Duration(days: 5)), 'is encashment'),
];

class MockWetzikonCurrency extends Currency {
  MockWetzikonCurrency()
      : super(
            'wetzicoin', 'wetzicoin', 'CHF', 0, 2, null, null, true, null, 10);
}

const PrivateWalletID = 'DR345GH67';
const PrivatePublicKey = 'tz1Ns3YQJR6piMZ8GrD2iYu94Ybi1HFfNyBP';
const ShopWalletID = '45FGH62SD';
const ShopPublicKey = 'tz1Ns3YQJR6piMZ8GrD2iEn34Ybi1HFfNyBP';

lib.Wallet privateWalletMock = lib.Wallet(
    PrivateWalletID,
    PrivatePublicKey,
    MockWetzikonCurrency(),
    lib.WalletCategoy.consumer,
    105,
    lib.WalletState.verified);
lib.Wallet shopWalletMock = lib.Wallet(
    ShopWalletID,
    ShopPublicKey,
    MockWetzikonCurrency(),
    lib.WalletCategoy.company,
    1059,
    lib.WalletState.pending);

List<WalletEntity> MockWallets = [
  WalletEntity(privateWalletMock),
  WalletEntity(shopWalletMock)
];
