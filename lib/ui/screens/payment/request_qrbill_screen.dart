import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RequestQRBillScreen extends StatelessWidget {
  static const double _topSectionHeight = 150.0;

  final RequestData requestData;

  RequestQRBillScreen(this.requestData);

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    return MainLayout(
      title: Text('QR Rechnung'),
      // body: Text(requestData.amount.toString()),
      body: Container(
        // height: _topSectionHeight,
        // child: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Wallet ${requestData.requesterId}'),
              Text('CHF ${requestData.amount.toString()}'),
              RepaintBoundary(
                child: QrImage(
                  data: requestData.amount.toString(),
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
  }
}
