import 'package:e_coupon/business/get_wallets.dart';

class MockTransaction {
  final text;
  final amount;
  final isEncashment;

  MockTransaction({this.text, this.amount, this.isEncashment = false});
}

class MockWallet extends Wallet {
  MockWallet({id, amount, currency, isShop, transactions})
      : super(
            id: id,
            amount: amount,
            currency: currency,
            isShop: isShop,
            transactions: transactions);
}

var MockWallets = [
  MockWallet(
      id: 'DR345GH67',
      amount: 105.50,
      currency: 'Wetzikon',
      transactions: [
        MockTransaction(text: 'Pusteblume GmBH', amount: -12.50),
        MockTransaction(text: 'Confiserie Sprüngli', amount: -120.50),
        MockTransaction(
            text: 'Wallet-ID DR345GH67',
            amount:
                20), // braucht transaction noch einen Text, bzw einen Namen (zB Sepp - danke für die Pizza)
        MockTransaction(text: 'Bäckerei Jung', amount: -12.50),
      ]),
  MockWallet(
      id: '45FGH62SD',
      amount: 1059.00,
      currency: 'Wetzikon',
      transactions: [
        MockTransaction(text: 'Wallet-ID ER345GH57', amount: 12.50),
        MockTransaction(text: 'Wallet-ID FDR335GH67', amount: 120.50),
        MockTransaction(
            text: 'Wallet-ID AR345GF67',
            amount:
                20), // braucht transaction noch einen Text, bzw einen Namen (zB Sepp - danke für die Pizza)
        MockTransaction(
            text: 'eingelöst bei Gemeinde', amount: -12.50, isEncashment: true),
      ])
];
