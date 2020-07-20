import 'package:e_coupon/business/entities/currency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Wallet extends Equatable {
  final String id;
  final double amount;
  final Currency currency;
  final bool isShop;
  // final List<TransactionRecord> transactions;

  Wallet(
      {@required this.id,
      @required this.amount,
      @required this.currency,
      this.isShop = false});

  @override
  List<Object> get props => [id, amount, currency, isShop];
}
