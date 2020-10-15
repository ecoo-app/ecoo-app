import 'dart:convert';

import 'package:e_coupon/business/entities/wallet.dart';

enum MigrationStateEnum { WaitingForCheck, Checking, Migrating, Done, Fail }

class MigrationCheckItem {
  MigrationStateEnum state;
  IWalletEntity wallet;
  final String walletID;

  MigrationCheckItem(this.state, this.walletID, {this.wallet});

  factory MigrationCheckItem.from(
      IWalletEntity other, MigrationStateEnum state) {
    return MigrationCheckItem(state, other.id);
  }

  MigrationCheckItem.fromJson(Map<String, dynamic> json)
      : state = MigrationStateEnum.values[jsonDecode(json['state'])],
        walletID = json['walletID'];

  Map<String, dynamic> toJson() => {
        'state': jsonEncode(state.index),
        'walletID': walletID,
      };
}
