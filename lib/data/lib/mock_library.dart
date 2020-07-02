enum VerificationState { Open, Pending, Successful }

abstract class Currency {
  String id;
  String label;
}

abstract class Wallet {
  String walletId;
  Currency currency;
  bool isShop;
  double amount;
  VerificationState verificationState;
}

enum InputType { Text, Number, Date }

abstract class VerificationInput {
  String id;
  Map<String, String> i18nLabel;
  InputType inputType;
}

abstract class TransactionRecord {
  String text;
  double amount;
  List<Tag> tags;
}

abstract class Tag {
  String id;
  // maby also some humanreadable id/label for translation of labels?
  String label;
}

abstract class LibAPI {
  // wallet creation
  Future<Wallet> createWalletForUser(
      String userIdentification, String currencyId, bool isShop);
  Future<List<Currency>> getCurrencies();
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
  Future<Currency> getGemeindeWalletId(String currencyId);

  // wallet data
  Future<List<Wallet>> getAllWalletsForUser(String userIdentification);
  // TODO pagination cursor format
  Future<List<TransactionRecord>> getTransactionsForWallet(
      String walletId, paginationCursor); // filter?
  Future<Wallet> getWalletData(String walletId);
}
