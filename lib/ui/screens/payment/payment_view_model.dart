import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:injectable/injectable.dart';

@injectable
class PaymentViewModel extends BaseViewModel {
  // handel sender id in a context visible for all?
  String senderId;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
  final recieverInputController = TextEditingController();

  PaymentViewModel();

  void init(String senderId) {
    this.senderId = senderId;
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    amountInputController.dispose();
    recieverInputController.dispose();
    super.dispose();
  }
}
