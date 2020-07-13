import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/model/wallet_model.dart';

import 'mock_data.dart';
import 'mock_library.dart';

class LibWalletSource implements LibAPI {
  // wallet creation
  @override
  Future<WalletAPI> createWalletForUser(
      String userIdentification, String currencyId, bool isShop) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }

  @override
  Future<List<CurrencyAPI>> getCurrencies() {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }

  @override
  Future<List<VerificationInputAPI>> getVerificationInputs(
      String currencyId, bool isShop) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }

  // verification
  @override
  Future<VerificationState> verifyWallet(
      String walletID, Map<String, dynamic> verificationInputs) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }

  // transaction
  @override
  initTransaction(
      String myWalletId, String recieverWalletId, double transactionAmount) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }

  @override
  Future<CurrencyAPI> getGemeindeWalletId(String currencyId) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }

  // wallet data
  @override
  Future<List<WalletAPI>> getAllWalletsForUser(String userIdentification) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }

  // TODO pagination cursor format
  @override
  Future<List<TransactionRecordAPI>> getTransactionsForWallet(
      String walletId, paginationCursor) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  } // filter?

  @override
  Future<WalletAPI> getWalletData(String walletId) {
    // TODO: implement createWalletForUser
    throw UnimplementedError();
  }
}
