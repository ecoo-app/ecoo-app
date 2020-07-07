import 'package:equatable/equatable.dart';

// TODO Equatable only works for immutable classes. This doesnt work here.
class Transaction extends Equatable {
  String senderId;
  String recieverId;
  double amount;

  Transaction({this.senderId, this.recieverId, this.amount});

  set sender(String senderId) => this.senderId = senderId;
  set reciever(String recieverId) => this.recieverId = recieverId;
  set transactionAmount(double amount) => this.amount = amount;

  @override
  List<Object> get props => [senderId, recieverId, amount];
}
