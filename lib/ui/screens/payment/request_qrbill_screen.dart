import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/screens/payment/qrbill_view_model.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../injection.dart';

@injectable
class RequestQRBillScreen extends StatelessWidget {
  // ignore: unused_field
  static const double _topSectionHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    return BaseView<QRBillViewModel>(
      model: getIt<QRBillViewModel>(),
      builder: (_, vmodel, __) {
        return MainLayout(
          isShop: vmodel.isShop,
          title: I18n.of(context).titleRequestScreen,
          body: Container(
            // height: _topSectionHeight,
            // child: Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(I18n.of(context)
                      .walletRequestScreen(vmodel.transferData.reciever.id)),
                  Text(I18n.of(context).amountRequestScreen(
                      vmodel.transferData.toAmountCurrencyLabel())),
                  RepaintBoundary(
                    child: QrImage(
                      data: vmodel.qrImageDate,
                      size: 0.5 * bodyHeight,
                      errorStateBuilder: (cxt, err) {
                        return Container(
                          child: Center(
                            child: Text(
                              "Uh oh! Something went wrong...",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      // onError: (ex) {
                      //   print("[QR] ERROR - $ex");
                      //   setState((){
                      //     _inputErrorText = "Error! Maybe your input value is too long?";
                      //   });
                      // },
                    ),
                  )
                ],
              ),
            ),
          ),
          // ),
        );
      },
    );
  }
}
