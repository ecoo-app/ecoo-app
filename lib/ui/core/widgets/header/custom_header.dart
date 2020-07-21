import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomHeader extends StatelessWidget {
  final String closeIcon;
  final VoidCallback onClose;

  const CustomHeader({Key key, this.closeIcon, this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 20),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 15, right: 5),
                child: IconButton(
                  icon: SvgPicture.asset(closeIcon),
                  iconSize: LayoutStyles.iconSize,
                  onPressed: onClose,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
