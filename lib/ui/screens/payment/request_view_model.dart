import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
}
