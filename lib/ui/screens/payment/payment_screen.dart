import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/widgets/button/rhombus_icon_button.dart';
import 'package:e_coupon/ui/core/widgets/ec_text_form_field.dart';
import 'package:e_coupon/ui/screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_view_model.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/core/widgets/amount_input.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../injection.dart';

@injectable
class PaymentScreen extends StatelessWidget {
  final WalletEntity sender;

  PaymentScreen({@required this.sender});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isShop: false,
      title: I18n.of(context).titlePaymentScreen,
      body: BaseView<PaymentViewModel>(
          model: getIt<PaymentViewModel>(),
          onModelReady: (vmodel) => vmodel.init(this.sender),
          builder: (context, vmodel, child) {
            return Center(
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
                    RhombusIconButton(
                      onPressed: () {
                        vmodel.next();
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
