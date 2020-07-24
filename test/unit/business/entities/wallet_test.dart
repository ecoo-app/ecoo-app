import 'package:e_coupon/business/entities/wallet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecoupon_lib/models/wallet.dart' as libWallet;
import 'package:ecoupon_lib/models/currency.dart' as libCurrency;

void main() {
  test('get string with currency and amount', () async {
    var wallet = WalletEntity(libWallet.Wallet('TestID', 'TestKey',
        libCurrency.Currency('CHF', 'CHF', 0), false, 1000, 'testState'));

    expect(wallet.toAmountCurrencyLabel(), 'CHF 10.00');
  });
}
