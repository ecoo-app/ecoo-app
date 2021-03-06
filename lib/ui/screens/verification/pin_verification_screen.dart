import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/flat_secondary_button.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/ec_text_form_field.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/screens/verification/pin_verification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';

@injectable
class PinVerificationScreen extends StatelessWidget {
  final PinVerificationViewModel _viewModel;

  PinVerificationScreen(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return BaseView<PinVerificationViewModel>(
      model: this._viewModel,
      onModelReady: (vmodel) => vmodel.init(),
      builder: (context, vmodel, child) {
        return MainLayout(
          insets: null,
          isShop: vmodel.wallet.isShop,
          title: I18n.of(context).pinVerificationTitle,
          body: (() {
            if (vmodel.viewState is Error) {
              Error error = vmodel.viewState;
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ErrorToast(failure: error.failure).create(context)
                  ..show(context);
              });
            }
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 160, left: 25, right: 25, top: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(I18n.of(context).pinRecieved,
                            style: Theme.of(context).textTheme.caption),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          vmodel.wallet.currency.label,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        vmodel.wallet.isShop
                            ? Text(I18n.of(context).enterPinShop)
                            : Text(I18n.of(context).enterPinPrivate),
                        SizedBox(
                          height: 62,
                        ),
                        Form(
                          child: ECTextFormField(
                            keyboardType: TextInputType.number,
                            label: I18n.of(context).pinInputLabel,
                            onChanged: (value) => vmodel.pin = value,
                            validator: (value) {
                              if (value.isEmpty) {
                                return I18n.of(context).inputValidation;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 130,
                    child: Column(
                      children: [
                        vmodel.wallet.isShop
                            ? FlatSecondaryButton(
                                textColor: ColorStyles.red,
                                onPressed: vmodel.onSkip,
                                text: I18n.of(context).verifyPinLater,
                              )
                            : SizedBox.shrink(),
                        PrimaryButton(
                          isLoading: vmodel.viewState is Loading,
                          text: I18n.of(context).verifyPinButton,
                          onPressed: () => vmodel.onVerify(
                              I18n.of(context).successTextVerification),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }()),
        );
      },
    );
  }
}
