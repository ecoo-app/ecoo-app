import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String text;
  final double amount;
  final bool isEncashment;

  Transaction({this.text, this.amount, this.isEncashment = false});

  @override
  List<Object> get props => [text, amount, isEncashment];
}
