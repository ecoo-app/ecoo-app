import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/screens/payment/qrbill_view_model.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math' as math;

import '../../../injection.dart';

@injectable
class RequestQRBillScreen extends StatelessWidget {
  Widget _buildTexts(BuildContext context, QRBillViewModel vmodel) {
    return Column(
      children: [
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
            style: Theme.of(context)
                .textTheme
                .headline4
                .merge(TextStyle(color: ColorStyles.black))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    return BaseView<QRBillViewModel>(
      model: getIt<QRBillViewModel>(),
      onModelReady: (QRBillViewModel vmodel) => vmodel.init(),
      builder: (BuildContext context, QRBillViewModel vmodel, Widget child) {
        return MainLayout(
          leadingType: BackButtonType.Back,
          isShop: vmodel.isShop,
          title: I18n.of(context).titleRequestScreen,
          body: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildTexts(context, vmodel),
                      SizedBox(
                        height: 8,
                      ),
                      RepaintBoundary(
                        child: QrImage(
                          foregroundColor: ColorStyles.black,
                          data: vmodel.qrImageData,
                          gapless: true,
                          size: 0.37 * bodyHeight,
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
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Transform.rotate(
                          angle: math.pi, child: _buildTexts(context, vmodel))
                    ],
                  ),
                ),
              ),
              vmodel.isShop
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      child: OutlinedSecondaryButton(
                        text: I18n.of(context).scanPaperWalletButton,
                        onPressed: vmodel.onPaperWalletScan,
                        svgAsset: Assets.icon_qrcode_color_svg,
                      ),
                    )
                  : Container(),
            ],
          ),
          // ),
        );
      },
    );
  }
}
