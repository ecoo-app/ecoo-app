import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/date_form_field.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/core/widgets/form/verification_form_field.dart';
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
import 'package:provider/provider.dart';

@injectable
class VerificationScreen extends StatefulWidget {
  final VerificationViewModel _viewModel;

  VerificationScreen(this._viewModel);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  VerificationViewModel get viewModel => widget._viewModel;

  void verifyAndSend() {
    if (_formKey.currentState.validate()) {
      viewModel.onVerify(I18n.of(context).successTextVerification);
    }
  }

  Widget _generatePrivateWalletVerificationForm(VerificationInputData value) {
    return ListView(
      padding: EdgeInsets.only(top: 25),
      children: <Widget>[
        VerificationFormTitle(
            text: I18n.of(context).verificationPrivateFormTitle),
        VerificationFormField(
          model: value.firstName,
          label: I18n.of(context).verifyFormFieldFirstName,
        ),
        VerificationFormField(
          model: value.lastName,
          label: I18n.of(context).verifyFormFieldLastName,
        ),
        VerificationFormField(
            model: value.phoneNumber,
            label: I18n.of(context).verifyFormFieldPhoneNumber,
            keyboardType: TextInputType.phone),
        DateFormField(
          labelText: I18n.of(context).verifyFormFieldBirthday,
          suffixIcon: Icon(Icons.calendar_today),
          initialDate: DateTime.now(),
          firstDate: DateTime.utc(1870),
          lastDate: DateTime.now(),
          onDateChanged: value.dateOfBirth.setValue,
        ),
      ],
    );
  }

  Widget _generateShopWalletVerificationForm(VerificationInputData value) {
    return ListView(
      padding: EdgeInsets.only(top: 25),
      children: <Widget>[
        VerificationFormTitle(text: I18n.of(context).verificationShopFormTitle),
        VerificationFormUid(model: value.uid),
        VerificationFormTitle(
            text: I18n.of(context).verificationShopFormCompanyTitle),
        VerificationFormField(
          model: value.address,
          label: I18n.of(context).verifyFormFieldCompany,
        ),
        VerificationFormField(
          model: value.address,
          label: I18n.of(context).verifyFormFieldAddress,
        ),
        VerificationFormField(
          model: value.postcode,
          label: I18n.of(context).verifyFormFieldPostcode,
        ),
        VerificationFormField(
          model: value.city,
          label: I18n.of(context).verifyFormFieldCity,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isShop: viewModel.isShop,
      title: I18n.of(context).titleFormClaimVerification,
      leadingType: BackButtonType.Close,
      insets: EdgeInsets.symmetric(horizontal: 24),
      body: (() {
        if (viewModel.viewState is Loading) {
          return ECProgressIndicator();
        } else if (viewModel.viewState is Error) {
          Error error = viewModel.viewState;
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ErrorToast(failure: error.failure).create(context)..show(context);
          });
          return Container();
        } else {
          return ChangeNotifierProvider<VerificationInputData>.value(
            value: viewModel.inputData,
            child: Form(
                key: _formKey,
                child: Consumer<VerificationInputData>(
                  builder: (context, value, child) {
                    return viewModel.isShop
                        ? _generateShopWalletVerificationForm(value)
                        : _generatePrivateWalletVerificationForm(value);
                  },
                )),
          );
        }
      }()),
      bottom: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 25, left: 25, right: 25),
        child: PrimaryButton(
          isLoading: viewModel.viewState is VerificationLoading,
          text: I18n.of(context).buttonFormClaimVerification,
          onPressed: verifyAndSend,
        ),
      ),
    );
  }
}
