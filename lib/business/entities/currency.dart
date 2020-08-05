import 'package:equatable/equatable.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;

class Currency extends Equatable {
  final lib.Currency _currency;

  Currency(this._currency);

  String get id => this._currency.uuid;
  String get label => this._currency.name;
  String get symbol => this._currency.symbol;
  lib.Currency get currencyModel => this._currency;

  @override
  List<Object> get props => [_currency];
}
