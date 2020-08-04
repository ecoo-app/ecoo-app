import 'package:e_coupon/business/entities/wallet.dart';
import 'package:ecoupon_lib/models/currency.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib;

import 'mock_library.dart';

class MockTransaction extends TransactionRecordAPI {
  MockTransaction(String text, double amount, List<TagAPI> tags)
      : super(text: text, amount: amount, tags: tags);
}

class MockEncashmentTag extends TagAPI {
  MockEncashmentTag() : super(id: 'isEncashment', label: 'isEncashment');
}

List<TransactionRecordAPI> MockTransactionWalletPrivate = [
  MockTransaction('Wallet-ID ertl34u53', 12.50, []),
  MockTransaction('Wallet-ID sdfsdfwet', -20.00, []),
  MockTransaction('Wallet-ID 345fdget5', 11.00, []),
  MockTransaction('Wallet-ID erfgb4545', -4.50, []),
  MockTransaction('Wallet-ID 3w45g5467', 13.60, []),
];

List<TransactionRecordAPI> MockTransactionWalletShop = [
  MockTransaction('Wallet-ID ertl34u53', 12.50, []),
  MockTransaction('Wallet-ID sdfsdfwet', 20.00, []),
  MockTransaction('Wallet-ID 345fdget5', 11.00, []),
  MockTransaction('Wallet-ID erfgb4545', -4.50, []),
  MockTransaction('Wallet-ID 3w45g5467', 13.60, [MockEncashmentTag()]),
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
    lib.WalletState.verified);

List<WalletEntity> MockWallets = [
  WalletEntity(privateWalletMock),
  WalletEntity(shopWalletMock)
];
