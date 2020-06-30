import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/get_all_wallets.dart';
import 'package:e_coupon/ui/core/base_view_model.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallet_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_coupon/ui/core/viewstate.dart';

class WalletsViewModel extends BaseViewModel {
  List<Wallet> _wallets = [];
  final GetAllWallets _getAllWallets;

  WalletsViewModel({getAllWallets}) : _getAllWallets = getAllWallets;

  List<Wallet> get wallets => _wallets;

  void loadWallets() async {
    setState(ViewState.Busy);

    Future.delayed(const Duration(seconds: 1), () async {
      print('load wallets');
      var walletsOrFailure =
          await _getAllWallets(Params(userIdentifier: 'string'));
      walletsOrFailure.fold(
          (failure) => print('FAILURE'), (wallets) => _wallets = wallets);

      setState(ViewState.Idle);
    });
  }

  // List<Wallet> get allWallets {
  //   setState(ViewState.Loading);

  //   _getAllWallets(Params(userIdentifier: 'string'))
  //       .then((walletsOrFailure) => {
  //             walletsOrFailure.fold(
  //               (failure) => print('FAILURE'),
  //               (wallets) => _wallets = wallets,
  //             )
  //           })
  //       .catchError((onError) => print(onError));

  //   setState(ViewState.Idle);
  //   return _wallets;
  // }
}
