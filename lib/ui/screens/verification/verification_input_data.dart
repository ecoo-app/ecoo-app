import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:flutter/widgets.dart';

class VerificationInputData extends ChangeNotifier {
  TextVerificationInput firstName;
  TextVerificationInput lastName;
  PhoneNumberVerificationInput phoneNumber;
  DateVerificationInput dateOfBirth;
  AddressVerificationInput address;

  TextVerificationInput noUidStreet;
  TextVerificationInput noUidPostalCode;
  TextVerificationInput noUidCity;

  OriginVerificationInput origin;

  TextVerificationInput companyName;
  UidVerificationInput uid;

  bool _isTruth = false;

  VerificationInputData() {
    // Private Wallet Fields
    dateOfBirth = DateVerificationInput();
    lastName = TextVerificationInput();
    firstName = TextVerificationInput();
    origin = OriginVerificationInput();

    // Common Fields
    phoneNumber = PhoneNumberVerificationInput();
    address = AddressVerificationInput();

    // Shop Wallet Fields
    companyName = TextVerificationInput();
    uid = UidVerificationInput();

    noUidStreet = TextVerificationInput();
    noUidPostalCode = TextVerificationInput();
    noUidCity = TextVerificationInput();

    firstName.addListener(onChanged);
    lastName.addListener(onChanged);
    phoneNumber.addListener(onChanged);
    dateOfBirth.addListener(onChanged);
    address.addListener(onChanged);
    uid.addListener(onChanged);
    companyName.addListener(onChanged);
    origin.addListener(onChanged);
    noUidStreet.addListener(onChanged);
    noUidPostalCode.addListener(onChanged);
    noUidCity.addListener(onChanged);
  }

  bool get isTruth => _isTruth;

  bool get hasUID => !uid.hasNoUid;

  bool isValid(bool isShop) {
    var validFormInput = false;
    if (isShop && hasUID) {
      validFormInput = _shopWalletMandatoryFields
          .where((element) => !element.isValid)
          .isEmpty;
    } else if (isShop && !hasUID) {
      validFormInput = _shopWalletMandatoryFieldsNoUid
          .where((element) => !element.isValid)
          .isEmpty;
    } else {
      validFormInput = _privateWalletMandatoryFields
          .where((element) => !element.isValid)
          .isEmpty;
    }
    return _isTruth && validFormInput;
  }

  List<VerificationInput> get _privateWalletMandatoryFields =>
      [firstName, lastName, phoneNumber, dateOfBirth, address, origin];

  List<VerificationInput> get _shopWalletMandatoryFields =>
      [companyName, address, uid];

  List<VerificationInput> get _shopWalletMandatoryFieldsNoUid =>
      [companyName, uid, noUidStreet, noUidPostalCode, noUidCity];

  void onChanged() {
    notifyListeners();
  }

  void onIsThruthChanged(bool value) {
    _isTruth = value;
    notifyListeners();
  }

  UserProfileEntity toProfileEntity(String walletId) => UserProfileEntity(
      '',
      walletId,
      firstName.value,
      lastName.value,
      phoneNumber.value,
      dateOfBirth.input,
      address.input.street,
      address.input.city,
      address.input.postalCode,
      origin.value,
      VerificationStage.notMatched);

  CompanyProfileEntity toCompanyEntity(String walletId) => hasUID
      ? CompanyProfileEntity(
          '',
          walletId,
          companyName.value,
          uid.value,
          address.input.street,
          address.input.city,
          address.input.postalCode,
          phoneNumber.value,
          VerificationStage.notMatched)
      : CompanyProfileEntity(
          '',
          walletId,
          companyName.value,
          uid.value,
          noUidStreet.value,
          noUidCity.value,
          noUidPostalCode.value,
          phoneNumber.value,
          VerificationStage.notMatched);
}
