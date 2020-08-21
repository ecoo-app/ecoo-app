import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:flutter/widgets.dart';

class VerificationInputData extends ChangeNotifier {
  TextVerificationInput firstName = TextVerificationInput();
  TextVerificationInput lastName = TextVerificationInput();
  PhoneNumberVerificationInput phoneNumber = PhoneNumberVerificationInput();
  DateVerificationInput dateOfBirth = DateVerificationInput();
  TextVerificationInput address = TextVerificationInput(optional: true);
  TextVerificationInput postcode = TextVerificationInput(optional: true);
  TextVerificationInput city = TextVerificationInput(optional: true);

  TextVerificationInput name = TextVerificationInput();
  UidVerificationInput uid = UidVerificationInput();

  bool _isTruth = false;

  VerificationInputData() {
    firstName.addListener(onChanged);
    lastName.addListener(onChanged);
    phoneNumber.addListener(onChanged);
    dateOfBirth.addListener(onChanged);
    address.addListener(onChanged);
    postcode.addListener(onChanged);
    name.addListener(onChanged);
    uid.addListener(onChanged);
    city.addListener(onChanged);
  }

  bool get isTruth => _isTruth;

  void onChanged() {
    notifyListeners();
  }

  void onIsThruthChanged(bool value) {
    _isTruth = value;
    notifyListeners();
  }

  UserProfileEntity toProfileEntity() => UserProfileEntity(
      '',
      '',
      firstName.value,
      lastName.value,
      phoneNumber.value,
      dateOfBirth.input,
      address.value,
      city.value,
      postcode.value,
      VerificationStage.notMatched);

  CompanyProfileEntity toCompanyEntity() => CompanyProfileEntity(
      '',
      '',
      name.value,
      uid.value,
      address.value,
      city.value,
      postcode.value,
      VerificationStage.notMatched);
}
