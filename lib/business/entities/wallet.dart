import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:ecoupon_lib/models/wallet.dart';

enum WalletStage {
  Undefined, // Do we need this?
  VerificationOpen,
  PendingAnswer,
  PendingPin,
  Verified // TODO naming?
}

abstract class IWalletEntity {
  final String _walletID;
  final int _balance;
  final Currency _currency;
  final bool _isShop;
  final WalletStage _walletStage;

  final Wallet _libWallet;

  IWalletEntity(this._walletID, this._balance, this._currency, this._isShop,
      this._walletStage, this._libWallet);

  String get id => this._walletID;
  String get balanceLabel => Utils.moneyToString(this._balance);
  int get balance => this._balance;
  Currency get currency => this._currency;
  bool get isShop => this._isShop;
  WalletStage get walletStage => this._walletStage;

  Wallet get libWallet => this._libWallet;

  String toBalanceCurrencyLabel() =>
      '${_libWallet.currency.symbol} $balanceLabel';
}
// WalletEntity from wallet, profiles

class WetzikonWalletEntity extends IWalletEntity {
  final List<ProfileEntity> _profiles;

  WetzikonWalletEntity(walletID, balance, currency, isShop, walletStage,
      this._profiles, libWallet)
      : super(walletID, balance, currency, isShop, walletStage, libWallet);

  factory WetzikonWalletEntity.from(Wallet other,
      {List<ProfileEntity> profiles}) {
    return WetzikonWalletEntity(
        other.walletID,
        other.balance,
        Currency(other.currency),
        other.category == WalletCategory.company,
        _createWalletStage(other, profiles),
        profiles == null ? [] : profiles,
        other);
  }

// this is very specific logic for the wetzikon verification process.
// for later: how to separate such logic?
  List<ProfileEntity> get profiles => this._profiles;

  static WalletStage _createWalletStage(
      Wallet wallet, List<ProfileEntity> profiles) {
    //
    if (profiles == null || profiles.isEmpty) {
      return WalletStage.VerificationOpen;
    }

    var pendingPins = profiles.where(
        (profile) => profile.verificationStage == VerificationStage.pendingPIN);
    var maxReached = profiles.where((profile) =>
        profile.verificationStage == VerificationStage.maxClaimsReached);
    var verified = profiles.where(
        (profile) => profile.verificationStage == VerificationStage.verified);
    var notMatched = profiles.where(
        (profile) => profile.verificationStage == VerificationStage.notMatched);

    // consumer wallet can have more than one verified profiles. Therefore we first have to check if there is a pending one.
    if (pendingPins.isNotEmpty) {
      return WalletStage.PendingPin;
    }

    if (wallet.category == WalletCategory.consumer &&
        (maxReached.isNotEmpty || notMatched.isNotEmpty)) {
      return WalletStage.PendingAnswer;
    }

    // for Companies -> for private ??? if one is verified, it doesnt mean that another one is not beeing processed -> but starting from maxReached!
    if (verified.isNotEmpty) {
      return WalletStage.Verified;
    }

    // if wallet is shop wallet and neither verification is open nor pin is pending or verification is finished
    return WalletStage.PendingAnswer;
  }
}
