import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterScaffold extends StatelessWidget {
  final String title;
  final String subhead;
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

    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                header,
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 90, bottom: 10),
                          child: Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .merge(
                                      TextStyle(fontWeight: fontWeightBold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 20),
                          child: Text(
                            subhead,
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        content,
                      ],
                    ),
                  ),
                ),
                footer ?? Container()
              ],
            )));
  }
}
