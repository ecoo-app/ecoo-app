import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String id;
  final double amount;
  final Currency currency;
  final bool isShop;
  final List<TransactionRecord> transactions;

  Wallet(
      {this.id,
      this.amount,
      this.currency,
      this.isShop = false,
      this.transactions});

  @override
  List<Object> get props => [id, amount, currency, isShop, transactions];
}
