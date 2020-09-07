import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/ec_text_form_field.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/screens/redeem/redeem_view_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class RedeemScreen extends StatelessWidget {
  final RedeemViewModel _viewModel;

  RedeemScreen(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return BaseView<RedeemViewModel>(
      model: this._viewModel,
      onModelReady: (vmodel) => vmodel.init(),
      builder: (context, vmodel, child) {
        return MainLayout(
          insets: null,
          isShop: vmodel.wallet.isShop,
          title: I18n.of(context).titleRedeem,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 36, bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      vmodel.wallet.amountLabel,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      vmodel.wallet.currency.symbol,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(I18n.of(context).redeemTransferTo,
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
                  Text(I18n.of(context).redeemInfo),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                      child: Column(
                    children: <Widget>[
                      ECTextFormField(
                        label: I18n.of(context).redeemFieldNameBank,
                        onChanged: (value) => vmodel.nameOfBank = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return I18n.of(context).inputValidation;
                          }
                          return null;
                        },
                      ),
                      ECTextFormField(
                        label: I18n.of(context).redeemFieldIBAN,
                        onChanged: (value) => vmodel.iban = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return I18n.of(context).inputValidation;
                          }
                          return null;
                        },
                      ),
                      ECTextFormField(
                        label: I18n.of(context).redeemFieldAccountOwner,
                        onChanged: (value) => vmodel.owner = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return I18n.of(context).inputValidation;
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 48),
                        child: PrimaryButton(
                          isLoading: vmodel.viewState is Loading,
                          text: I18n.of(context).buttonRedeem,
                          onPressed: () => vmodel
                              .onRedeem(I18n.of(context).verificationSend),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
