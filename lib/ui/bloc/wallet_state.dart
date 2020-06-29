part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

/// Empty State
class Empty extends WalletState {
  @override
  List<Object> get props => [];
}

/// Loading State
class Loading extends WalletState {
  @override
  List<Object> get props => [];
}

/// Loaded State
class Loaded extends WalletState {
  final Wallet wallet;

  Loaded({@required this.wallet});

  @override
  List<Object> get props => [wallet];
}

/// Error State
class Error extends WalletState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
