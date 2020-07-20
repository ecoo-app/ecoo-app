import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class PrimaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final colorTheme;
  final bool isLoading;

  PrimaryButton(
      {this.onPressed,
      @required this.text,
      this.colorTheme,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 24, left: 4, right: 4),
      child: GradientButton(
        increaseHeightBy: 15,
        increaseWidthBy: double.infinity,
        gradient: Gradients.coldLinear,
        // gradient: ThemeGradients.defaultGradient,
        callback: onPressed,
        shapeRadius: BorderRadius.all(Radius.circular(10)),
        child: isLoading
            ? Row(
                children: <Widget>[
                  CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white)),
                  Text(text)
                ],
              )
            : Text(
                text,
              ),
        elevation: 0,
        // textColor: Colors.white,
        // color: Colors.cyan,
      ),
      // SizedBox(
      //     width: double.infinity,
      //     height: 50,
      //     child: GradientButton(
      //       increaseHeightBy: 50,
      //       increaseWidthBy: double.infinity,
      //       gradient: Gradients.coldLinear,
      //       // gradient: ThemeGradients.defaultGradient,
      //       callback: onPressed,
      //       shapeRadius: BorderRadius.all(Radius.circular(10)),
      //       child: isLoading
      //           ? Row(
      //               children: <Widget>[
      //                 CircularProgressIndicator(
      //                     valueColor:
      //                         new AlwaysStoppedAnimation<Color>(Colors.white)),
      //                 Text(text)
      //               ],
      //             )
      //           : Text(
      //               text,
      //             ),
      //       elevation: 0,
      //       // textColor: Colors.white,
      //       // color: Colors.cyan,
      //     ),
      //     ),
    );
  }

// https://stackoverflow.com/questions/52243364/flutter-how-to-make-a-raised-button-that-has-a-gradient-background
// TODO
  // @override
  // Widget build(BuildContext context) {
  //   return new Expanded(
  //       child: new Container(
  //           margin: const EdgeInsets.all(20),
  //           child: new FlatButton(
  //               onPressed: () {},
  //               textColor: Colors.white,
  //               padding: const EdgeInsets.all(0.0),
  //               child: new Row(children: <Widget>[
  //                 new Expanded(
  //                     child: Container(
  //                   decoration: const BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: <Color>[
  //                         Color(0xFF0D47A1),
  //                         Color(0xFF1976D2),
  //                         Color(0xFF42A5F5),
  //                       ],
  //                     ),
  //                   ),
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: new Center(
  //                       child: new Text(text, style: TextStyle(fontSize: 20))),
  //                 )),
  //               ]))));
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return RawMaterialButton(
  //     fillColor: Colors.white,
  //     child: Padding(
  //         padding: EdgeInsets.all(10.0),
  //         child: new Row(children: <Widget>[
  //           new Expanded(
  //               child: Container(
  //             decoration: const BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: <Color>[
  //                   Color(0xFF0D47A1),
  //                   Color(0xFF1976D2),
  //                   Color(0xFF42A5F5),
  //                 ],
  //               ),
  //             ),
  //             padding: const EdgeInsets.all(10.0),
  //             child: new Center(
  //                 child: new Text(text, style: TextStyle(fontSize: 20))),
  //           )),
  //         ])),
  //     onPressed: onPressed,
  //     //shape: const StadiumBorder(),
  //   );
  // }
}
