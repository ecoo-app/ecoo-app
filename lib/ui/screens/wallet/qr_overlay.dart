import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_flutter/qr_flutter.dart';

@injectable
class WalletQROverlay extends StatelessWidget {
  final PartialPainter painter = PartialPainter();

  @override
  Widget build(BuildContext context) {
    // final bodyHeight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).viewInsets.bottom;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          CustomHeader(
            closeIcon: Assets.close_svg,
            onClose: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'walletid',
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
                          data: 'walletid',
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

class PartialPainter extends CustomPainter {
  PartialPainter({this.radius, this.strokeWidth, this.gradient});
  final Paint paintObject = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;
  @override
  void paint(Canvas canvas, Size size) {
    Rect topLeftTop = Rect.fromLTRB(0, 0, size.height / 4, strokeWidth);
    Rect topLeftLeft = Rect.fromLTRB(0, 0, strokeWidth, size.height / 4);
    Rect bottomRightBottom = Rect.fromLTRB(size.width - size.height / 4,
        size.height - strokeWidth, size.width, size.height);
    Rect bottomRightRight = Rect.fromLTRB(
        size.width - strokeWidth, size.height * 3 / 4, size.width, size.height);
    paintObject.shader = gradient.createShader(Offset.zero & size);
    Path topLeftPath = Path()..addRect(topLeftTop)..addRect(topLeftLeft);
    Path bottomRightPath = Path()
      ..addRect(bottomRightBottom)
      ..addRect(bottomRightRight);
    Path finalPath =
        Path.combine(PathOperation.union, topLeftPath, bottomRightPath);
    canvas.drawPath(finalPath, paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
