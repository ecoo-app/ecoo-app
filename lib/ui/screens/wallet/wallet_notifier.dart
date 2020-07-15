import 'package:e_coupon/ui/core/model/wallet_state.dart';
import 'package:state_notifier/state_notifier.dart';

// todo use state notifiers instead of change notifiers?
class WalletNotifier extends StateNotifier<WalletState> {
  WalletNotifier() : super(WalletState());
}
