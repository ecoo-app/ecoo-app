import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomHeader extends StatelessWidget {
  final String closeIcon;
  final Color closeIconColor;
  final VoidCallback onClose;
  final String headline;

  const CustomHeader(
      {Key key,
      this.headline,
      this.closeIcon,
      this.closeIconColor,
      this.onClose})
      : super(key: key);

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
                  key: Key('close_button'),
                  icon: SvgPicture.asset(
                    closeIcon,
                    color: closeIconColor,
                  ),
                  iconSize: LayoutStyles.iconSize,
                  onPressed: onClose,
                ),
              ),
              headline == null
                  ? Container()
                  : Expanded(
                      child: Text(
                        headline,
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
              Container(
                child: Container(width: 40),
              )
            ],
          ),
        )
      ],
    );
  }
}
