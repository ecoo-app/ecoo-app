part of 'wallet_bloc.dart';

/// Events should just passing data to the bloc. They should not have any presentation logic! (SOLID)
///
abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class SetWallet extends WalletEvent {
  final String id;

  SetWallet(this.id);

  @override
  List<Object> get props => [id];
}
