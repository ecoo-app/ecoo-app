import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:injectable/injectable.dart';

abstract class IProfileService {
  Future<ProfileEntity> currentProfile();

  Future<ProfileEntity> currentProfileForWallet(IWalletEntity wallet);

  Future<ProfileEntity> create(ProfileEntity profileEntity);

  Future<bool> verify(String pin, IWalletEntity wallet);

  Future<bool> testApi();
}

@Singleton(as: IProfileService)
class ProfileService implements IProfileService {
  final IWalletRepo _walletRepo;
  final IWalletService _walletService;
  final ISettingsService _settingsService;

  ProfileEntity _currentProfile;

  ProfileService(this._walletRepo, this._walletService, this._settingsService);

  @override

  /// throws Failure
  Future<ProfileEntity> create(ProfileEntity profileEntity) async {
    var currentWallet = _walletService.getSelected();

    var answer = await _walletRepo.createProfile(currentWallet, profileEntity);

    if (answer != null && answer.isRight()) {
      var profile = answer.getOrElse(() => null);
      await _settingsService.writeSecureString(
          Constants.userProfileUuid, profile.uuid);
      return profile;
    }

    if (answer.isLeft()) {
      answer.fold((failure) {
        throw failure;
      }, (r) => null);
    }
    return null;
  }

  Future<List<ProfileEntity>> fetchProfiles() async {
    var answer = await _walletRepo.profiles(false);
    if (answer.isRight()) {
      var profiles = answer.getOrElse(() => null);
      return profiles ?? [];
    } else {
      if (answer.isLeft()) {
        var error = answer.getOrElse(() => null);
        throw error;
      }
    }

    return [];
  }

  Future<List<ProfileEntity>> fetchProfilesForWallet(
      IWalletEntity wallet) async {
    var answer =
        await _walletRepo.profiles(wallet.isShop, forWalletId: wallet.id);
    if (answer.isRight()) {
      var profiles = answer.getOrElse(() => null);
      return profiles ?? [];
    } else {
      if (answer.isLeft()) {
        var error = answer.getOrElse(() => null);
        throw error;
      }
    }

    return [];
  }

  @override
  Future<ProfileEntity> currentProfile() async {
    if (_currentProfile != null) {
      return _currentProfile;
    }

    var savedUuid =
        await _settingsService.readSecureString(Constants.userProfileUuid);

    var profiles = await fetchProfiles();
    if (profiles.isNotEmpty) {
      if (savedUuid != null) {
        var selected = profiles.firstWhere(
            (element) => element.uuid == savedUuid,
            orElse: () => null);
        if (selected != null) {
          _currentProfile = selected;
          return _currentProfile;
        }
      }

      var verifiedProfiles = profiles
          .where((element) =>
              element.verificationStage == VerificationStage.verified)
          .toList();

      if (verifiedProfiles.isNotEmpty) {
        _currentProfile = verifiedProfiles?.first;
        return _currentProfile;
      }
    }

    return _currentProfile;
  }

  @override
  Future<ProfileEntity> currentProfileForWallet(IWalletEntity wallet) async {
    var profiles = await fetchProfilesForWallet(wallet);
    if (profiles.isNotEmpty) {
      var pendingProfiles = profiles
          .where((element) =>
              element.verificationStage == VerificationStage.pendingPIN)
          .toList();

      if (pendingProfiles.isNotEmpty) {
        return pendingProfiles?.first;
      }
    }
    return null;
  }

  /// throws Failure
  @override
  Future<bool> verify(String pin, IWalletEntity wallet) async {
    ProfileEntity profileEntity = await currentProfileForWallet(wallet);
    // if (profileEntity is UserProfileEntity) {
    if (profileEntity != null) {
      var answer = await _walletRepo.verify(profileEntity, pin);
      if (answer.isRight()) {
        if (answer.getOrElse(() => false)) {
          return true;
        }
      } else {
        answer.fold((failure) => throw failure, (r) => null);
        return false;
      }
    }

    // }
    throw MessageFailure('Profile Entity is null');
  }

  @override
  Future<bool> testApi() async {
    var answer = await _walletRepo.profiles(false);
    var result = answer.fold((l) => throw l, (r) => true);
    return result;
  }
}
