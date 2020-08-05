import 'dart:async';

import 'package:ecoupon_lib/models/verification_input.dart';
import 'package:ecoupon_lib/services/wallet_service.dart';
import 'package:injectable/injectable.dart';

import 'mock_library.dart';

abstract class IWalletSource {
  WalletService get walletService;
}

@LazySingleton(as: IWalletSource)
class WalletSource extends IWalletSource {
  final WalletService service =
      WalletService("https://ecoupon-backend.dev.gke.papers.tech");

  WalletService get walletService => service;
}

@LazySingleton(as: ILibWalletSource)
class LibWalletSource implements ILibWalletSource {
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
  Future<List<VerificationInput>> getVerificationInputs(
      String currencyId, bool isShop) {
    List<VerificationInput> privateVerifications = [];

    privateVerifications.addAll([
      VerificationInput('Vorname', 'text'),
      VerificationInput('Name', 'text'),
      VerificationInput('Adresse', 'text'),
      // VerificationInput('number', 'Hausnummer', 'text'),
      // VerificationInput(
      //     id: 'extra',
      //     i18nLabel: 'Adresszusatz',
      //     inputType: 'text',
      //     isRequired: false),
      VerificationInput('PLZ', 'text'),
      // VerificationInput('city', 'Ort', 'text'),
      VerificationInput('Geburtsdatum', 'date'),
    ]);

    Completer completer = Completer<List<VerificationInput>>();
    completer.complete(privateVerifications);

    return completer.future;
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
