import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
}
