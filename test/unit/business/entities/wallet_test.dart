import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get string with currency and amount', () async {
    var wallet = Wallet(
        amount: 10.0,
        currency: Currency(id: 'CHF', label: 'CHF'),
        id: 'TestID',
        isShop: false);

        expect(wallet.toAmountCurrencyLabel(), 'CHF 10.00');
  });
}
