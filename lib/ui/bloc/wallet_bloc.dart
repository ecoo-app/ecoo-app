import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/get_wallet.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWallet getWallet;

  WalletBloc({@required this.getWallet});

  @override
  WalletState get initialState => Empty();

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
