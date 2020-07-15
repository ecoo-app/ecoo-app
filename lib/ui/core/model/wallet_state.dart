import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/data/model/currency_model.dart';
import 'package:injectable/injectable.dart';

// TODO use state notifier instead of change notifier?
@lazySingleton
class WalletState {
  String id = '';
  Currency currency = CurrencyModel(id: '', label: '');
  bool isShop = false;
  double amount = 0;
  List<TransactionRecord> transactions = [];
  // final String id;
  // final Currency currency;
  // final bool isShop;
  // ValueNotifier<double> _amountNotifier = ValueNotifier(0);
  // ValueNotifier<List<TransactionRecord>> _transactions = ValueNotifier([]);

  // SelectedWallet(this.id, this.currency, this.isShop);

}
