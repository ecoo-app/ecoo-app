import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_flutter/qr_flutter.dart';

@injectable
class WalletQROverlay extends StatelessWidget {
  final IWalletService _walletService;

  WalletQROverlay(this._walletService);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          CustomHeader(
            closeIcon: Assets.close_svg,
            onClose: () async {
              await _walletService.updateSelected();
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _walletService.getSelected().id,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 29,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // CustomPaint(
                    //   painter: painter
                    //   child: Container(
                    //     height: 100,
                    //   ),
                    // ),
                    Container(
                        //height: 100,
                        child: SvgPicture.asset(Assets.qr_code_frame_svg)),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: RepaintBoundary(
                        child: QrImage(
                          data: Utils.qrData(
                              destinationId: _walletService.getSelected().id),
                          size: screenWidth - 2 * 60,
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
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
