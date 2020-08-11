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

// class VerificationFormModel extends VerificationForm {
//   VerificationFormModel(
//       {@required String title, @required List<VerificationInput> inputs})
//       : super(title: title, inputModel: inputs);
// }

// class VerificationInputModel extends VerificationInput {
//   VerificationInputModel(
//       {@required String id,
//       @required String i18nLabel,
//       @required String inputType,
//       isRequired = true})
//       : super(i18nLabel, inputType);
// }

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
