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
    if (failure is NotAuthenticatedFailure) {
      return I18n.of(context).authFailureTitle;
    }
    if (failure is HTTPFailure) {
      return 'Server fehler ${(failure as HTTPFailure).code}';
    }
    if (failure is NoPinSetFailure) {
      return I18n.of(context).noPinFailureTitle;
    }
    if (failure is NoTransactionPossibleFailure) {
      return I18n.of(context).noTransactionFailureTitle;
    }
    return I18n.of(context).generalErrorTitle;
  }

  String _failureMessage(BuildContext context) {
    if (failure is NoService) {
      return I18n.of(context).noServiceErrorText;
    }
    if (failure is NotAuthenticatedFailure) {
      return I18n.of(context).authFailureText;
    }
    if (failure is HTTPFailure) {
      var responseDetails = (failure as HTTPFailure).response;
      if (responseDetails == null) {
        return '-';
      }

      String text = '';
      responseDetails.forEach((key, value) {
        for (var i = 0; i < value.length; i++) {
          if (i != 0) {
            text += '\n';
          }
          text += '${value[i]}';
        }
      });
      return text;
    }
    if (failure is MessageFailure) {
      MessageFailure fail = failure;
      return fail.message;
    }
    if (failure is NoPinSetFailure) {
      return I18n.of(context).noPinFailureText;
    }
    if (failure is NoTransactionPossibleFailure) {
      return I18n.of(context).noTransactionFailureText;
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
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .merge(TextStyle(color: ColorStyles.black)),
            )
          : Container(),
      messageText: Text(
        _failureMessage(context),
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(TextStyle(color: ColorStyles.black)),
      ),
    );
  }
}
