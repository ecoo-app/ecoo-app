class Utils {
  static int balanceFromString(String amount) {
    // TODO how to use local decimal separators... ?
    // List<String> splits = amount.split(".");
    // if (splits.length == 2) {
    //   return int.parse(splits[0]) * 100 + int.parse(splits[1]);
    // } else {
    //   return int.parse(splits[0]) * 100;
    // }
    return (double.parse(amount) * 100).floor();
  }

  static String moneyToString(int amount) {
    return (amount / 100).toStringAsFixed(2);
  }

  //   String toString() {
  //   return NumberFormat.currency(locale: locale, symbol: '')
  //       .format(amount / 100);
  // }

  static Map<String, RegExp> _getDefaultTranslator() {
    return {
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  static String maskString(String mask, String value) {
    String result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    var translator = _getDefaultTranslator();

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = mask[maskCharIndex];
      var valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator.containsKey(maskChar)) {
        if (translator[maskChar].hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}
