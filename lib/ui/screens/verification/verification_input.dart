import 'package:flutter/widgets.dart';
import 'package:e_coupon/core/extensions.dart';

abstract class VerificationInput {
  FocusNode focusNode;

  String get value;

  bool get isValid;

  void fieldFocusChange(BuildContext context);
}

class TextVerificationInput extends ChangeNotifier
    implements VerificationInput {
  final bool optional;

  String input;

  TextVerificationInput({
    this.optional = false,
  });

  @override
  String get value => input;

  @override
  bool get isValid {
    if (optional) {
      return true;
    }
    return value != null && value.isNotEmpty;
  }

  void setValue(String text) {
    input = text;
    notifyListeners();
  }

  @override
  FocusNode focusNode = FocusNode();

  @override
  void fieldFocusChange(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }
}

class DateVerificationInput extends ChangeNotifier
    implements VerificationInput {
  DateTime input;

  @override
  String get value => input.toString();

  @override
  bool get isValid {
    return true;
  }

  void setValue(DateTime date) {
    input = date;
    notifyListeners();
  }

  @override
  FocusNode focusNode = FocusNode();

  @override
  void fieldFocusChange(BuildContext context) {}
}

class PhoneNumberVerificationInput extends TextVerificationInput {
  String input;

  @override
  bool get isValid {
    if (input.isNullOrEmpty()) {
      return false;
    }

    var lengthOk = input.length == 12;
    return lengthOk;
  }

  @override
  String get value => isValid ? '+41${input?.replaceAll(' ', '') ?? ''}' : '';

  void setValue(String text) {
    input = text;
    notifyListeners();
  }
}

class UidVerificationInput extends TextVerificationInput {
  bool hasNoUid = false;

  String text;

  @override
  String get value {
    if (hasNoUid) {
      return '';
    } else {
      return isValid ? 'CHE-${input}' : '';
    }
  }

  @override
  void setValue(String text) {
    input = text;
    notifyListeners();
  }

  @override
  bool get isValid {
    if (hasNoUid) {
      return true;
    }
    if (input.isNullOrEmpty()) {
      return false;
    }

    final lengthOk = input.length == 11;
    var expression = RegExp(r'\b([0-9]{3,3})');
    var matches = expression.allMatches(input);
    final threeParts = matches.length == 3;
    final containsDots = '.'.allMatches(input).length == 2;

    return !hasNoUid && lengthOk && threeParts && containsDots;
  }

  String tempInput = '';
  void hasNoUidChanged(bool value) {
    hasNoUid = value;
    if (hasNoUid) {
      tempInput = input;
      setValue('');
    }
    if (!hasNoUid) {
      setValue(tempInput);
    }
    notifyListeners();
  }
}

class Address {
  String street;
  String postalCode;
  String city;

  Address({this.street, this.postalCode, this.city});
}

class AddressVerificationInput extends ChangeNotifier
    implements VerificationInput {
  final bool optional;

  Address input;

  AddressVerificationInput({
    this.optional = false,
  });

  @override
  String get value =>
      input == null ? '' : '${input.street}, ${input.postalCode} ${input.city}';

  @override
  bool get isValid {
    if (optional) {
      return true;
    }
    return value != null && value.isNotEmpty;
  }

  void setValue(Address address) {
    input = address;
  }

  void notifyChangeListeners() {
    print('on save');
    notifyListeners();
  }

  @override
  FocusNode focusNode = FocusNode();

  @override
  void fieldFocusChange(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }
}
