import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/mock_data.dart';
import 'package:injectable/injectable.dart';

abstract class IQRScanParser {
  Transfer parseTransaction(String url);
}

@LazySingleton(as: IQRScanParser)
class MockQRScanParser extends IQRScanParser {
  @override
  Transfer parseTransaction(String url) {
    return Transfer(
      sender: WalletEntity(privateWalletMock),
      reciever: WalletEntity(shopWalletMock),
      amount: 2000,
    );
  }
}
