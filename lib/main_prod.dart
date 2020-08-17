import 'package:e_coupon/injection.dart';
import 'package:e_coupon/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Env.prod);

  var app = getIt.get<ECouponApp>();
  
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(app));
}
