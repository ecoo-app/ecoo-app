import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterScaffold extends StatelessWidget {
  final String title;
  final Widget subhead;
  // final String subhead;
  // final String link;
  final Widget header;
  final Widget content;
  final Widget footer;

  const RegisterScaffold({
    Key key,
    @required this.title,
    @required this.subhead,
    this.header,
    this.content,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topPadding = header != null ? 15 : 70;
    return Scaffold(
        body: SafeArea(
            bottom: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                header == null ? SizedBox.shrink() : header,
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, top: topPadding, bottom: 10),
                            child: Text(title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .merge(
                                        TextStyle(fontWeight: fontWeightBold))),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 25),
                              child: subhead),
                          content,
                        ],
                      ),
                    ),
                  ),
                ),
                footer ?? Container()
              ],
            )));
  }
}
