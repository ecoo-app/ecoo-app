import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';

class MockTransactionModel extends TransactionRecord {
  final text;
  final amount;
  final isEncashment;

  MockTransactionModel({this.text, this.amount, this.isEncashment = false});
}

class MockWalletModel extends Wallet {
  MockWalletModel({id, amount, currency, isShop, transactions})
      : super(
            id: id,
            amount: amount,
            currency: currency,
            isShop: isShop,
            transactions: transactions);
}

var MockWallets = [
  MockWalletModel(
      id: 'DR345GH67',
      amount: 105.50,
      currency: 'Wetzikon',
      transactions: [
        MockTransactionModel(text: 'Pusteblume GmBH', amount: -12.50),
        MockTransactionModel(text: 'Confiserie Sprüngli', amount: -120.50),
        MockTransactionModel(
            text: 'Wallet-ID DR345GH67',
            amount:
                20), // braucht transaction noch einen Text, bzw einen Namen (zB Sepp - danke für die Pizza)
        MockTransactionModel(text: 'Bäckerei Jung', amount: -12.50),
      ]),
  MockWalletModel(
      id: '45FGH62SD',
      amount: 1059.00,
      currency: 'Wetzikon',
      transactions: [
        MockTransactionModel(text: 'Wallet-ID ER345GH57', amount: 12.50),
        MockTransactionModel(text: 'Wallet-ID FDR335GH67', amount: 120.50),
        MockTransactionModel(
            text: 'Wallet-ID AR345GF67',
            amount:
                20), // braucht transaction noch einen Text, bzw einen Namen (zB Sepp - danke für die Pizza)
        MockTransactionModel(
            text: 'eingelöst bei Gemeinde', amount: -12.50, isEncashment: true),
      ])
];

TransactionState MockTransactionState = TransactionState();
