import 'get_wallets.dart';

abstract class IWalletRepo {
  List<Wallet> getWallets();
  Wallet getWalletData(id);
  void getWalletTransactions(id, filter); // and pagination cursor?
}
