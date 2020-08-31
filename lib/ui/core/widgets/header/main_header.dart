import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MainHeader extends StatelessWidget implements PreferredSizeWidget {
  final Size _preferredSize = Size.fromHeight(120);
  final String leadingIcon;
  final VoidCallback onBack;
  final String headline;
  final Gradient gradient;

  MainHeader(
      {Key key, this.headline, this.leadingIcon, this.onBack, this.gradient})
      : super(key: key);

  @override
  Size get preferredSize => this._preferredSize;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).padding.top - 20;
    return Container(
      height: 120 + height,
      decoration:
          ShapeDecoration(shape: MainHeaderShapeBorder(), gradient: gradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                key: Key('close_button'),
                icon: SvgPicture.asset(
                  leadingIcon,
                  color: Colors.white,
                ),
                iconSize: LayoutStyles.iconSize,
                onPressed: onBack,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  headline,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: ColorStyles.black)),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MainHeaderShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, rect.height);
    path.lineTo(90, rect.height);
    path.cubicTo(
        100, rect.height, 100, rect.height - 14, 110, rect.height - 14);
    path.lineTo(rect.width, rect.height - 14);
    path.lineTo(rect.width, 0);
    path.close();

    return path;
  }
}

// class MyPainter extends CustomPainter {
//     @override
//     void paint(Canvas canvas, Size size) {
//       Paint paint = Paint();
//       Path path = Path();

//       // Path number 1

//       paint.color = Color(0xffffffff).withOpacity(0);
//       path = Path();
//       path.lineTo(0, 0);
//       path.cubicTo(0, 0, -1, 0, -1, 0);
//       path.cubicTo(-1, 0, -1, size.height, -1, size.height);
//       path.cubicTo(-1, size.height, -0.75, size.height, -0.75, size.height);
//       path.cubicTo(-0.69, size.height, -0.7, size.height * 1.02, -0.67, size.height * 0.9);
//       path.cubicTo(-0.66, size.height * 0.85, -0.65, size.height * 0.86, -0.6, size.height * 0.86);
//       path.cubicTo(-0.6, size.height * 0.86, 0, size.height * 0.86, 0, size.height * 0.86);
//       canvas.drawPath(path, paint);
//     }
//     @override
//     bool shouldRepaint(CustomPainter oldDelegate) {
//       return true;
//     }
//   }
