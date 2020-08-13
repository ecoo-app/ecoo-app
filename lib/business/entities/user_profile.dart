import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:ecoupon_lib/models/user_profile.dart' as lib_user;
import 'package:ecoupon_lib/models/company_profile.dart' as lib_company;

abstract class ProfileEntity {
  String get uuid;

  VerificationStage get verificationStage;
}

class CompanyProfileEntity implements ProfileEntity {
  final String _uuid;
  final String walletId;
  final String name;
  final String uid;
  final String addressStreet;
  final String addressTown;
  final String addressPostalCode;
  final VerificationStage _verificationState;

  CompanyProfileEntity(
    this._uuid,
    this.walletId,
    this.name,
    this.uid,
    this.addressStreet,
    this.addressTown,
    this.addressPostalCode,
    this._verificationState,
  );

  @override
  VerificationStage get verificationStage => _verificationState;

  @override
  String get uuid => _uuid;

  factory CompanyProfileEntity.from(lib_company.CompanyProfile other) {
    return CompanyProfileEntity(
        other.uuid,
        other.walletID,
        other.name,
        other.uid,
        other.addressStreet,
        other.addressTown,
        other.addressPostalCode,
        other.verificationStage);
  }

  lib_company.CompanyProfile toLibProfile() {
    return lib_company.CompanyProfile(
      uuid,
      walletId,
      name,
      uid,
      addressStreet,
      addressTown,
      addressPostalCode,
      verificationStage,
    );
  }
}

class UserProfileEntity implements ProfileEntity {
  final String _uuid;
  final String walletId;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String phoneNumber;
  final String addressStreet;
  final String addressTown;
  final String postcode;
  final VerificationStage _verificationState;

  UserProfileEntity(
    this._uuid,
    this.walletId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.addressStreet,
    this.addressTown,
    this.postcode,
    this._verificationState,
  );

  factory UserProfileEntity.from(lib_user.UserProfile other) {
    return UserProfileEntity(
        other.uuid,
        other.walletID,
        other.firstName,
        other.lastName,
        other.telephoneNumber,
        other.dateOfBirth,
        other.addressStreet,
        other.addressTown,
        other.addressPostalCode,
        other.verificationStage);
  }

  lib_user.UserProfile toLibProfile() {
    return lib_user.UserProfile(
      uuid,
      walletId,
      firstName,
      lastName,
      addressStreet,
      addressTown,
      postcode,
      phoneNumber,
      dateOfBirth,
      verificationStage,
    );
  }

  @override
  VerificationStage get verificationStage => _verificationState;

  @override
  String get uuid => _uuid;
}
