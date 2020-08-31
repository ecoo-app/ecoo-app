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
        builder:
            (BuildContext context, RequestViewModel vmodel, Widget widget) {
          return MainLayout(
              onBackPressed: vmodel.onBack,
              leadingType: BackButtonType.Close,
              isShop: vmodel.wallet.isShop,
              title: I18n.of(context).titlePrivateRequest,
              insets: null,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Form(
                              key: vmodel.formKey,
                              child: Column(
                                children: <Widget>[
                                  AmountInputField(
                                      controller: vmodel.amountInputController,
                                      currency: vmodel.wallet.currency),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: PrimaryButton(
                      text: vmodel.wallet.isShop
                          ? I18n.of(context).buttonShopRequest
                          : I18n.of(context).buttonPrivateRequest,
                      isEnabled: vmodel.isInputValid(),
                      onPressed: () {
                        vmodel.next();
                      },
                    ),
                  )
                ],
              ));
        });
  }
}
