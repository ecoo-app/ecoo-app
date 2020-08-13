import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/ec_text_form_field.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/screens/payment/payment_view_model.dart';
import 'package:e_coupon/ui/core/widgets/amount_input.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';

import '../../../injection.dart';

@injectable
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentViewModel>(
        model: getIt<PaymentViewModel>(),
        onModelReady: (vmodel) => vmodel.init(),
        builder: (context, vmodel, child) {
          if (vmodel.viewState is Error) {
            Error error = vmodel.viewState;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ErrorToast(failure: error.failure).create(context)..show(context);
            });
          }
          return MainLayout(
              leadingType: BackButtonType.Back,
              isShop: vmodel.isShop,
              onBackPressed: vmodel.onBack,
              title: I18n.of(context).titlePaymentScreen,
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Form(
                          key: vmodel.formKey,
                          child: Column(
                            children: <Widget>[
                              AmountInputField(
                                controller: vmodel.amountInputController,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              ECTextFormField(
                                hint: I18n.of(context).labelRecieverInput,
                                label: I18n.of(context).hintRecieverInput,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return I18n.of(context)
                                        .validationRecieverInput;
                                  }
                                  return null;
                                },
                                controller: vmodel.recieverInputController,
                              ),
                            ],
                          )),
                      PrimaryButton(
                        text: I18n.of(context).buttonPaymentOverview,
                        isLoading: vmodel.viewState is Loading,
                        onPressed: () async {
                          vmodel.initiateTransaction(
                              I18n.of(context).paymentSuccessful);
                        },
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
