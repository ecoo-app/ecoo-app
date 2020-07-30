import 'package:e_coupon/data/e_coupon_library/mock_data.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/screens/payment/qr_scanner_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  final double _qrRectSize = 230;
  final double _headerSize = 120;
  final double _qrIconPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yay we are scanning!')),
      body: BaseView<QRScannerViewModel>(
        model: getIt<QRScannerViewModel>(),
        builder: (context, vmodel, child) {
          return Stack(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
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
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              _headerSize -
                              _qrRectSize +
                              _qrIconPadding) /
                          2,
                    ),
                    Stack(
                      children: <Widget>[
                        SizedBox(
                          height: _qrRectSize,
                          width: _qrRectSize,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: SvgPicture.asset(Assets.qr_code_svg),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    OutlinedSecondaryButton(
                      text: 'fake scan',
                      // icon: Icon(Icons.feedback),
                      onPressed: () => vmodel
                          .onCodeRead('walletid:$ShopWalletID,amount:1000'),
                    )
                  ],
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 4),
                    child: OutlinedSecondaryButton(
                      text: 'manuell eingeben',
                      onPressed: () => vmodel.next(),
                    ),
                  ),
                  // child: Padding(
                  //   padding: const EdgeInsets.only(
                  //       bottom: 52, left: 25, right: 25),
                  //   child: SecondaryButton(
                  //     text: 'manuell eingeben',
                  //     icon: Icon(Icons.keyboard),
                  //     onPressed: () => vmodel.next(),
                  //   ),
                  // ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
