import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorToast {
  final Failure failure;

  ErrorToast({@required this.failure});

  String _failureTitle(BuildContext context) {
    if (failure is NoService) {
      return I18n.of(context).noServiceErrorTitle;
    }
    return I18n.of(context).generalErrorTitle;
  }

  String _failureMessage(BuildContext context) {
    if (failure is NoService) {
      return I18n.of(context).noServiceErrorText;
    }
    if (failure is MessageFailure) {
      MessageFailure fail = failure;
      return fail.message;
    }
    return I18n.of(context).generalErrorText;
  }

  Flushbar create(BuildContext context) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      backgroundColor: Colors.white,
      isDismissible: true,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.error_outline,
        color: Colors.redAccent,
      ),
      boxShadows: [
        BoxShadow(
            color: Colors.black12, offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      titleText: _failureTitle(context) != null
          ? Text(
              _failureTitle(context),
              style: TextStyles.body_text_black,
            )
          : Container(),
      messageText: Text(
        _failureMessage(context),
        style: TextStyles.body_text_black,
      ),
    );
  }
}
