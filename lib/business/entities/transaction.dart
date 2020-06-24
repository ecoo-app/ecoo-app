import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final text;
  final amount;
  final isEncashment;

  Transaction({this.text, this.amount, this.isEncashment = false});

  @override
  List<Object> get props => [text, amount, isEncashment];
}
