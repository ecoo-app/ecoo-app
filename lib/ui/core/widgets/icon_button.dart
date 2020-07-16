import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;
  final String text;

  CustomIconButton(
      {@required this.onPressed, @required this.icon, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RawMaterialButton(
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: Colors.white,
        child: Icon(
          icon,
          // size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
      Padding(padding: const EdgeInsets.only(top: 8)),
      Text(text)
    ]);

    // return RawMaterialButton(
    //   fillColor: Colors.white,
    //   child: Padding(
    //     padding: EdgeInsets.all(10.0),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         Icon(
    //           icon,
    //           color: Colors.black,
    //         ),
    //         SizedBox(
    //           width: 10.0,
    //         ),
    //         Padding(padding:
    //         EdgeInsets.fromLTRB(0, 8.0, 0, 0),
    //         child: Text(
    //           text,
    //           maxLines: 1,
    //           style: TextStyle(color: Colors.black),
    //         ),)
    //       ],
    //     ),
    //   ),
    //   onPressed: onPressed,
    //   //shape: const StadiumBorder(),
    // );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return RawMaterialButton(
  //     fillColor: Colors.green,
  //     splashColor: Colors.greenAccent,
  //     child: Padding(
  //       padding: EdgeInsets.all(10.0),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: const <Widget>[
  //           Icon(
  //             Icons.face,
  //             color: Colors.amber,
  //           ),
  //           SizedBox(
  //             width: 10.0,
  //           ),
  //           Text(
  //             "Tap Me",
  //             maxLines: 1,
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //     onPressed: onPressed,
  //     shape: const StadiumBorder(),
  //   );
  // }
}
