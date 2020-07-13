import 'dart:async';

import 'package:injectable/injectable.dart';

import 'mock_library.dart';

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
  Future<List<VerificationInputModel>> getVerificationInputs(
      String currencyId, bool isShop) {
    List<VerificationInputModel> privateVerifications = List();
    privateVerifications.addAll([
      VerificationInputModel(
          id: 'name',
          i18nLabel: {'de': 'Vorname'},
          inputType: InputTypeAPI.Text),
      VerificationInputModel(
          id: 'surname',
          i18nLabel: {'de': 'Name'},
          inputType: InputTypeAPI.Text),
      VerificationInputModel(
          id: 'street',
          i18nLabel: {'de': 'Strasse'},
          inputType: InputTypeAPI.Text),
      VerificationInputModel(
          id: 'number',
          i18nLabel: {'de': 'Hausnummer'},
          inputType: InputTypeAPI.Text),
      VerificationInputModel(
          id: 'extra',
          i18nLabel: {'de': 'Adresszusatz'},
          inputType: InputTypeAPI.Text,
          isRequired: false),
      VerificationInputModel(
          id: 'postalcode',
          i18nLabel: {'de': 'PLZ'},
          inputType: InputTypeAPI.Text),
      VerificationInputModel(
          id: 'city', i18nLabel: {'de': 'Ort'}, inputType: InputTypeAPI.Text),
      VerificationInputModel(
          id: 'birthdate',
          i18nLabel: {'de': 'Geburtsdatum'},
          inputType: InputTypeAPI.Date),
    ]);

    Completer completer = Completer<List<VerificationInputModel>>();
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
