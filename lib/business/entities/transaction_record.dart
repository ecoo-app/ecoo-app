import 'package:equatable/equatable.dart';

class TransactionRecord extends Equatable {
  final String text;
  final double amount;
  final bool isEncashment;

  TransactionRecord({this.text, this.amount, this.isEncashment = false});

  @override
  List<Object> get props => [text, amount, isEncashment];
}
