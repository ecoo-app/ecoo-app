import 'package:e_coupon/business/entities/verification_form.dart';
import 'package:ecoupon_lib/models/verification_input.dart';
import 'package:meta/meta.dart';

enum VerificationState { Open, Pending, Successful }

abstract class CurrencyAPI {
  String id;
  String label;

  CurrencyAPI({this.id, this.label});
}

abstract class WalletAPI {
  String walletId;
  CurrencyAPI currency;
  bool isShop;
  double amount;
  VerificationState verificationState;

  WalletAPI(
      {this.walletId,
      this.currency,
      this.isShop,
      this.amount,
      this.verificationState});
}

class VerificationFormModel extends VerificationForm {
  VerificationFormModel(
      {@required String title, @required List<VerificationInput> inputs})
      : super(title: title, inputModel: inputs);
}

class VerificationInputModel extends VerificationInput {
  VerificationInputModel(
      {@required String id,
      @required String i18nLabel,
      @required String inputType,
      isRequired = true})
      : super(i18nLabel, inputType);
}

abstract class TransactionRecordAPI {
  String text;
  double amount;
  List<TagAPI> tags;

  TransactionRecordAPI({this.text, this.amount, this.tags});
}

abstract class TagAPI {
  String id;
  // maby also some humanreadable id/label for translation of labels?
  String label;

  TagAPI({this.id, this.label});
}

abstract class ILibWalletSource {
  // wallet creation
  Future<WalletAPI> createWalletForUser(
      String userIdentification, String currencyId, bool isShop);
  Future<List<CurrencyAPI>> getCurrencies();
  Future<List<VerificationInput>> getVerificationInputs(
      String currencyId, bool isShop);

  // verification
  /// verificationInputs is a map of inputfield ids and input values
  Future<VerificationState> verifyWallet(
      String walletID, Map<String, dynamic> verificationInputs);

  // transaction
  // TODO what is the return type of initTransaction?
  initTransaction(
      String myWalletId, String recieverWalletId, double transactionAmount);
  Future<CurrencyAPI> getGemeindeWalletId(String currencyId);

  // wallet data
  Future<List<WalletAPI>> getAllWalletsForUser(String userIdentification);
  // TODO pagination cursor format
  Future<List<TransactionRecordAPI>> getTransactionsForWallet(
      String walletId, paginationCursor); // filter?
  Future<WalletAPI> getWalletData(String walletId);
}
