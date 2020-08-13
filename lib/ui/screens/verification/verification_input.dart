import 'package:flutter/widgets.dart';

abstract class VerificationInput {
  String get value;

  bool isValid();
}

class TextVerificationInput extends ChangeNotifier
    implements VerificationInput {
  final bool optional;

  String input;

  TextVerificationInput({this.optional = false});

  @override
  String get value => input;

  @override
  bool isValid() {
    if (optional) {
      return true;
    }
    return value != null && value.isNotEmpty;
  }

  void setValue(String text) {
    input = text;
    notifyListeners();
  }
}

class DateVerificationInput extends ChangeNotifier
    implements VerificationInput {
  DateTime input;

  @override
  String get value => input.toString();

  @override
  bool isValid() {
    return true;
  }

  void setValue(DateTime date) {
    input = date;
    notifyListeners();
  }
}

class PhoneNumberVerificationInput extends TextVerificationInput {
  String input;

  @override
  bool isValid() {
    if (input != null && input.isNotEmpty && isNumeric(input)) {
      return true;
    }

    return false;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  String get value => input;

  void setValue(String text) {
    input = text;
    notifyListeners();
  }
}

class UidVerificationInput extends TextVerificationInput {
  String part1;
  String part2;
  String part3;
  String part4;

  bool hasUid = true;

  @override
  String get value => '${part1}-${part2}-${part3}-${part4}';

  @override
  void setValue(String text) {}

  @override
  bool isValid() {
    final partsOk = part1.length == 2 &&
        part2.length == 1 &&
        part3.length == 1 &&
        part4.length == 1;
    return partsOk && value.isNotEmpty;
  }

  void part1Changed(String text) {
    part1 = text;
    notifyListeners();
  }

  void part2Changed(String text) {
    part2 = text;
    notifyListeners();
  }

  void part3Changed(String text) {
    part3 = text;
    notifyListeners();
  }

  void part4Changed(String text) {
    part4 = text;
    notifyListeners();
  }

  void hasUidChanged(bool value) {
    hasUid = value;
    notifyListeners();
  }
}
