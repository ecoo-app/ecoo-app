import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:flutter/widgets.dart';

class VerificationInputData extends ChangeNotifier {
  TextVerificationInput firstName;
  TextVerificationInput lastName;
  PhoneNumberVerificationInput phoneNumber;
  DateVerificationInput dateOfBirth;
  TextVerificationInput address;
  TextVerificationInput postcode;
  TextVerificationInput city;

  TextVerificationInput companyName;
  UidVerificationInput uid;

  bool _isTruth = false;

  VerificationInputData() {
    // Private Wallet Fields
    dateOfBirth = DateVerificationInput();
    phoneNumber = PhoneNumberVerificationInput();
    lastName = TextVerificationInput();
    firstName = TextVerificationInput();

    // Common Fields
    city = TextVerificationInput(optional: true);
    postcode = TextVerificationInput(optional: true);
    address = TextVerificationInput(optional: true);

    // Shop Wallet Fields
    companyName = TextVerificationInput();
    uid = UidVerificationInput();

    firstName.addListener(onChanged);
    lastName.addListener(onChanged);
    phoneNumber.addListener(onChanged);
    dateOfBirth.addListener(onChanged);
    address.addListener(onChanged);
    postcode.addListener(onChanged);
    city.addListener(onChanged);
    uid.addListener(onChanged);
    companyName.addListener(onChanged);
  }

  bool get isTruth => _isTruth;

  bool get hasUID => !uid.hasNoUid;

  bool isValid(bool isShop) {
    var validFormInput = false;
    if (isShop) {
      validFormInput = _shopWalletMandatoryFields
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
      [firstName, lastName, phoneNumber, dateOfBirth];

  List<VerificationInput> get _shopWalletMandatoryFields =>
      [companyName, address, city, postcode, uid];

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
      address.value,
      city.value,
      postcode.value,
      VerificationStage.notMatched);

  CompanyProfileEntity toCompanyEntity(String walletId) => CompanyProfileEntity(
      '',
      walletId,
      companyName.value,
      uid.value,
      address.value,
      city.value,
      postcode.value,
      VerificationStage.notMatched);
}
