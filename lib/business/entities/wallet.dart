import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final id;
  final amount;
  final currency;
  final isShop;
  final transactions;

  Wallet(
      {this.id,
      this.amount,
      this.currency,
      this.isShop = false,
      this.transactions});

  @override
  List<Object> get props => [id, amount, currency, isShop, transactions];
}
