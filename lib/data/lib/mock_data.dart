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

class MockWetzikonCurrency extends CurrencyAPI {
  MockWetzikonCurrency() : super(id: 'wetzicoin', label: 'wetzicoin');
}

class MockWallet extends WalletAPI {
  MockWallet(String id, double amount, CurrencyAPI currency, bool isShop,
      VerificationState verificationState)
      : super(
            walletId: id,
            amount: amount,
            currency: currency,
            isShop: isShop,
            verificationState: verificationState);
}

const PrivateWalletID = 'DR345GH67';
const ShopWalletID = '45FGH62SD';

List<WalletAPI> MockWallets = [
  MockWallet(PrivateWalletID, 105.50, MockWetzikonCurrency(), false,
      VerificationState.Successful),
  MockWallet(ShopWalletID, 1059.00, MockWetzikonCurrency(), true,
      VerificationState.Successful)
];
