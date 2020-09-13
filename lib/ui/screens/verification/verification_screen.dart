import 'dart:io';

import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_address.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_date.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_checkbox.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_field.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_origin.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_phone.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_title.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_uid.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/verification/verification_input_data.dart';
import 'package:e_coupon/ui/screens/verification/verification_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

@injectable
class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  OverlayEntry overlayEntry;
  bool isKeyBoardVisible = false;

  double bottomInset = 25;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      bottomInset += 34;
      KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
          setState(() {
            isKeyBoardVisible = visible;
          });
        },
      );
    }
  }

  Widget _createVerifyButton(VerificationInputData value, BuildContext context,
      VerificationViewModel viewModel) {
    var isError =
        viewModel.viewState is Loading || !value.isValid(viewModel.isShop);

    return Container(
      margin: EdgeInsets.only(top: 32),
      child: PrimaryButton(
        isLoading: viewModel.viewState is Loading,
        text: I18n.of(context).buttonFormClaimVerification,
        isEnabled: !isError,
        onPressed: () async {
          await viewModel.onVerify(I18n.of(context).successTextVerification,
              I18n.of(context).verifyMaxClaimsReached,
              errorText: I18n.of(context).verifyFormErrorVerification);
        },
      ),
    );
  }

  Widget _generatePrivateWalletVerificationForm(VerificationInputData value,
      BuildContext context, VerificationViewModel viewModel) {
    return Padding(
      padding:
          EdgeInsets.only(top: 25, bottom: bottomInset, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          VerificationFormTitle(
              text: I18n.of(context).verificationPrivateFormTitle),
          VerificationFormField(
            model: value.firstName,
            label: I18n.of(context).verifyFormFieldFirstName,
          ),
          SizedBox(
            height: 32,
          ),
          VerificationFormField(
            model: value.lastName,
            label: I18n.of(context).verifyFormFieldLastName,
          ),
          SizedBox(
            height: 32,
          ),
          VerificationFormDateField(
            labelText: I18n.of(context).verifyFormFieldBirthday,
            suffixIcon: Icon(Icons.calendar_today),
            initialDate:
                value.dateOfBirth.input ?? DateTime.parse('2000-01-01'),
            firstDate: DateTime.utc(1900),
            lastDate: DateTime.now(),
            onDateChanged: value.dateOfBirth.setValue,
          ),
          SizedBox(
            height: 32,
          ),
          VerificationFormPhoneField(
            model: value.phoneNumber,
            label: I18n.of(context).verifyFormFieldPhoneNumber,
          ),
          SizedBox(
            height: 32,
          ),
          VerificationAddressField(
            model: value.address,
            label: I18n.of(context).verifyFormFieldAddress,
            suggestionsCallback: viewModel.fetchAutoCompletions,
          ),
          SizedBox(
            height: 32,
          ),
          VerificationFormOrigin(
            model: value.origin,
            label: I18n.of(context).verifyFormFieldHeimatort,
            citySuggestionsCallback: viewModel.fetchCityOfOriginSuggestions,
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: VerificationFormCheckBox(
              textPartStart: I18n.of(context).verificationFilledTruthfullyPart1,
              textUrlPart: I18n.of(context).verificationFilledTruthfullyPart2,
              textPartEnd: I18n.of(context).verificationFilledTruthfullyPart3,
              onChanged: value.onIsThruthChanged,
              value: value.isTruth,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          _createVerifyButton(value, context, viewModel)
        ],
      ),
    );
  }

  Widget _generateShopWalletVerificationForm(VerificationInputData value,
      BuildContext context, VerificationViewModel viewModel) {
    return Padding(
      padding:
          EdgeInsets.only(top: 25, bottom: bottomInset, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          VerificationFormTitle(
              text: I18n.of(context).verificationShopFormTitle),
          VerificationFormUid(model: value.uid),
          SizedBox(
            height: 32,
          ),
          VerificationFormTitle(
              text: I18n.of(context).verificationShopFormCompanyTitle),
          SizedBox(
            height: 32,
          ),
          VerificationFormField(
            model: value.companyName,
            label: I18n.of(context).verifyFormFieldCompany,
          ),
          SizedBox(
            height: 32,
          ),
          VerificationAddressField(
            model: value.address,
            label: I18n.of(context).verifyFormFieldAddress,
            suggestionsCallback: viewModel.fetchAutoCompletions,
          ),
          SizedBox(
            height: 32,
          ),
          VerificationFormPhoneField(
            model: value.phoneNumber,
            label: I18n.of(context).verifyFormShopFieldPhoneNumber,
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: VerificationFormCheckBox(
              textPartStart:
                  I18n.of(context).verificationFilledTruthfullyShopPart1,
              textUrlPart:
                  I18n.of(context).verificationFilledTruthfullyShopPart2,
              textPartEnd:
                  I18n.of(context).verificationFilledTruthfullyShopPart3,
              onChanged: value.onIsThruthChanged,
              value: value.isTruth,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          _createVerifyButton(value, context, viewModel)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerificationViewModel>(
        model: getIt<VerificationViewModel>(),
        builder: (context, viewModel, child) {
          return ChangeNotifierProvider<VerificationInputData>.value(
            value: viewModel.inputData,
            child: MainLayout(
              isShop: viewModel.isShop,
              title: I18n.of(context).titleFormClaimVerification,
              leadingType: BackButtonType.Close,
              insets: null,
              body: (() {
                if (viewModel.viewState is Error) {
                  Error error = viewModel.viewState;
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ErrorToast(failure: error.failure).create(context)
                      ..show(context);
                    viewModel.resetViewState();
                  });
                }

                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: viewModel.formKey,
                        child: Consumer<VerificationInputData>(
                          builder: (context, value, child) {
                            return viewModel.isShop
                                ? _generateShopWalletVerificationForm(
                                    value, context, viewModel)
                                : _generatePrivateWalletVerificationForm(
                                    value, context, viewModel);
                          },
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isKeyBoardVisible && Platform.isIOS
                            ? InputNextView()
                            : Container(),
                      ],
                    )
                  ],
                );
              }()),
            ),
          );
        });
  }
}

class InputNextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorStyles.bg_light_gray,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 24.0, top: 4.0, bottom: 4.0),
            onPressed: () {
              FocusScope.of(context).nextFocus();
            },
            child: Text(I18n.of(context).verifyFormFieldNextButton,
                style: TextStyle(
                    color: ColorStyles.black, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
