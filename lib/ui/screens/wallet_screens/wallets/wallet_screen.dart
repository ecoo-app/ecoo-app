import 'package:e_coupon/ui/screens/wallet_screens/wallet_view_model.dart';
import 'package:flutter/material.dart';

import 'wallet_state.dart';

class WalletScreen extends StatefulWidget {
  final walletId;

  WalletScreen({Key key, @required this.walletId});

  @override
  State<StatefulWidget> createState() {
    return new WalletState(walletId);
  }
}
