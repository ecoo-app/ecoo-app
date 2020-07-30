import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/screens/payment/request_view_model.dart';
import 'package:e_coupon/ui/core/widgets/amount_input.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<RequestViewModel>(
        model: getIt<RequestViewModel>(),
        onModelReady: (vmodel) => vmodel.init(),
        builder: (_, vmodel, __) {
          return MainLayout(
              leadingType: BackButtonType.Close,
              isShop: vmodel.wallet.isShop,
              title: I18n.of(context).titlePrivateRequest,
              body: Center(
                  child: Container(
                      child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Form(
                    key: vmodel.formKey,
                    child: Column(
                      children: <Widget>[
                        AmountInputField(
                          controller: vmodel.amountInputController,
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  child: PrimaryButton(
                    text: vmodel.wallet.isShop
                        ? I18n.of(context).buttonShopRequest
                        : I18n.of(context).buttonPrivateRequest,
                    onPressed: () {
                      vmodel.next();
                    },
                  ),
                ),
              ]))));
        });
  }
}
