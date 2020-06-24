import 'package:e_coupon/business/abstract_wallet_repo.dart';
import 'package:e_coupon/business/get_wallets.dart';
import 'package:e_coupon/data/mock_data.dart';

class WalletRepo implements IWalletRepo {
  @override
  void getWalletTransactions(id, filter) {
    // TODO: implement getWalletTransactions
  }

  @override
  List<Wallet> getWallets() {
    return MockWallets;
  }

  @override
  Wallet getWalletData(id) {
    for (final wallet in MockWallets) {
      if (wallet.id == id) return wallet;
    }

    return null;
  }
}
