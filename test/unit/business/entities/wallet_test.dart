import 'package:e_coupon/business/entities/wallet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib_wallet;
import 'package:ecoupon_lib/models/currency.dart' as lib_currency;

void main() {
  test('get string with currency and amount', () async {
    var wallet = WalletEntity(lib_wallet.Wallet('TestID', 'TestKey',
        lib_currency.Currency('CHF', 'CHF', 0), false, 1000, 'testState'));

    expect(wallet.toAmountCurrencyLabel(), 'CHF 10.00');
  });
}
