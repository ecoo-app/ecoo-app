import 'package:meta/meta.dart';

enum InputType { Text, Number, Date, Bool }

class VerificationInput {
  String id;
  Map<String, String> i18nLabel;
  Map<String, String> i18nHint;
  // TODO error message?
  bool isRequired;
  InputType inputType;

  VerificationInput(
      {@required this.id,
      @required this.i18nLabel,
      this.i18nHint,
      @required this.inputType,
      this.isRequired = true});
}
