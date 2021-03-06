import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/core/widgets/header/main_header.dart';
import 'package:e_coupon/ui/screens/payment/qr_scanner_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  final double _qrRectSize = 230;
  final bool showButton;

  QRScannerScreen({this.showButton = true});

  @override
  Widget build(BuildContext context) {
    return BaseView<QRScannerViewModel>(
      model: getIt<QRScannerViewModel>(),
      onModelReady: (vmodel) =>
          vmodel.init(I18n.of(context).transactionSuccessful),
      builder: (context, vmodel, child) {
        if (vmodel.viewState is Error) {
          Error error = vmodel.viewState;
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ErrorToast(failure: error.failure).create(context)..show(context);
          });
        }
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                child: Center(
                  child: QRView(
                    key: vmodel.qrKey,
                    onQRViewCreated: vmodel.onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.white,
                      borderRadius: 0,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: _qrRectSize,
                    ),
                  ),
                ),
              ),
              MainHeader(
                headline: I18n.of(context).titleScanScreen,
                leadingIcon: Assets.close_svg,
                onBack: vmodel.onBack,
                gradient: vmodel.isShop
                    ? GradientStyles.shopWalletAppbarGradient
                    : GradientStyles.privateWalletAppbarGradient,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: _qrRectSize,
                    width: _qrRectSize,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset(
                        Assets.qr_code_svg,
                      ),
                    ),
                  ),
                  vmodel.viewState is Loading
                      ? ECProgressIndicator()
                      : Container(),
                ],
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 48, horizontal: 25),
                    child: showButton
                        ? OutlinedSecondaryButton(
                            svgAsset: Assets.keyboard_purpe_svg,
                            text: I18n.of(context).cancelScan,
                            onPressed: () => vmodel.next(),
                          )
                        : Container(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
