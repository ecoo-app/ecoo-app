import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterScreenViewModel extends BaseViewModel {
  // ignore: unused_field
  final IRouter _router;

  RegisterScreenViewModel(this._router);

  Future<void> close() {
    //_router.pop();
    return Future.value();
  }

  Future<void> registerWithApple() {
    return Future.value();
  }

  Future<void> registerWithGoogle() {
    return Future.value();
  }
}
