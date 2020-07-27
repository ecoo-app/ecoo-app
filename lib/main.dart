import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/camera_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';

List<CameraDescription> cameras;

// Future<Null> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Fetch the available cameras before initializing the app.
//   try {
//     cameras = await availableCameras();
//   } on QRReaderException catch (e) {
//     logError(e.code, e.description);
//   }
//   runApp(new MyApp());
// }

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  QRReaderController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );

    animationController.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
    verticalPosition = Tween<double>(begin: 0.0, end: 300.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear))
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          animationController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    // pick the first available camera
    if (cameras.length > 0) {
      onNewCameraSelected(cameras[0]);
    } else
      print('keine kamera');
  }

  Animation<double> verticalPosition;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainLayout(
        isShop: false,
        title: 'Yay we are scanning!',
        body: Stack(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
            ),
            Center(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 300.0,
                    width: 300.0,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2.0)),
                    ),
                  ),
                  Positioned(
                    top: verticalPosition.value,
                    child: Container(
                      width: 300.0,
                      height: 2.0,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            PrimaryButton(text: 'manuell eingeben')
          ],
        ),
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'No camera selected',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return new AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: new QRReaderPreview(controller),
      );
    }
  }

  void onCodeRead(dynamic value) {
    showInSnackBar(value.toString());
    // ... do something
    // wait 5 seconds then start scanning again.
    new Future.delayed(const Duration(seconds: 5), controller.startScanning);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = new QRReaderController(cameraDescription, ResolutionPreset.low,
        [CodeFormat.qr, CodeFormat.pdf417], onCodeRead);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on QRReaderException catch (e) {
      logError(e.code, e.description);
      showInSnackBar('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
      controller.startScanning();
    }
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Env.dev);
  var cameraService = getIt.get<ICameraService>();
  cameraService.init();

  var app = getIt.get<ECouponApp>();
  runApp(app);
}

@injectable
class ECouponApp extends StatelessWidget {
  final Locale _locale = Locale('de', 'CH');

  final IRouter router;

  ECouponApp(this.router);

  @override
  Widget build(BuildContext context) {
    // autogenerated i18n delegate from vscode extension https://github.com/esskar/vscode-flutter-i18n-json
    final i18n = I18n.delegate;

    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(fallback: Locale("de", "CH")),
      theme: generalTheme,
      title: "eCoupon",
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: router.navigatorKey,
      initialRoute: SplashRoute,
    );
  }
}

/// ****
///
///
/// drafts
///
///
/// ****

// class TestApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return new HomeState();
//   }
// }

// class HomeState extends State<TestApp> {
//   var _isLoading = true;
//   var videos;

//   _fetchData() async {
//     print("fetch data");

//     final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final map = json.decode(response.body);
//       final videosJson = map["videos"];
//       // videosJson.forEach((video) {
//       //   print(video["name"]);
//       // });

//       setState(() {
//         _isLoading = false;
//         videos = videosJson;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: "übersicht",
//       home: new Scaffold(
//           appBar: new AppBar(title: new Text("Übersicht"), actions: <Widget>[
//             new IconButton(
//                 icon: new Icon(Icons.refresh),
//                 onPressed: () {
//                   print("Reloading...");
//                   setState(() {
//                     _isLoading = true;
//                   });
//                   _fetchData();
//                 })
//           ]),
//           body: new Center(
//             child: _isLoading
//                 ? new CircularProgressIndicator()
//                 : new ListView.builder(
//                     itemCount: videos != null ? videos.length : 0,
//                     itemBuilder: (context, i) {
//                       final video = videos[i];
//                       return new FlatButton(
//                           child: new VideoCell(video),
//                           onPressed: () {
//                             // TODO change to named route
//                             Navigator.push(context,
//                                 new MaterialPageRoute(builder: (context) {
//                               return new DetailPage();
//                             }));
//                           });
//                     }),
//           )),
//     );
//   }
// }

// class DetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('detail page'),
//       ),
//       body: new Center(child: new Text('Detail')),
//     );
//   }
// }

// class HomeWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemBuilder: (context, rowNumber) {
//         return new WalletListItem(); //new Text("row $rowNumber");
//       },
//       itemCount: 20,
//     );
//   }
// }

// class WalletListItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Column(
//       children: <Widget>[new Text("row"), new Divider(color: Colors.amber)],
//     );
//   }
// }
