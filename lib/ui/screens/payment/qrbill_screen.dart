import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
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
      onModelReady: (vmodel) => vmodel.init(),
      builder: (_, vmodel, __) {
        return MainLayout(
          leadingType: BackButtonType.Back,
          isShop: vmodel.isShop,
          title: I18n.of(context).titleRequestScreen,
          body: Container(
            // height: _topSectionHeight,
            // child: Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    I18n.of(context)
                        .walletRequestScreen(vmodel.transferData.destWalletId),
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .merge(TextStyle(color: ColorStyles.brown_gray)),
                  ),
                  Text(
                      I18n.of(context)
                          .amountRequestScreen(vmodel.transferData.amountLabel),
                      style: Theme.of(context).textTheme.headline4),
                  RepaintBoundary(
                    child: QrImage(
                      data: vmodel.qrImageData,
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
                  ),
                  vmodel.isShop
                      ? OutlinedSecondaryButton(
                          text: I18n.of(context).scanPaperWalletButton,
                          onPressed: vmodel.onPaperWalletScan,
                          svgAsset: Assets.icon_qrcode_svg,
                        )
                      : Container(),
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
