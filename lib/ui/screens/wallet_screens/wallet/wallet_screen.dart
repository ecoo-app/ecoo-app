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
