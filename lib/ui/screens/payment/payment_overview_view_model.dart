import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentOverviewViewModel extends BaseViewModel {
  final HandleTransaction handleTransaction;
  final IRouter _router;
  TransactionData transactionData;

  PaymentOverviewViewModel(this.handleTransaction, this._router);

  void initState({TransactionData transactionData}) {
    if (transactionData != null) {
      this.transactionData = transactionData;
    } else {
      this.transactionData = TransactionData();
    }
  }

  void initiateTransaction(String successText) async {
    setViewState(Loading());

    var transactionOrFailure = await handleTransaction(TransactionParams(
        sender: transactionData.sender,
        reciever: transactionData.reciever,
        amount: transactionData.amount));
    transactionOrFailure.fold(
        (failure) => setViewState(Error(failure)),
        (success) => SchedulerBinding.instance.addPostFrameCallback((_) {
              _router.pushNamed(SuccessRoute,
                  arguments: SuccessScreenArguments(
                      isShop: false,
                      text: successText,
                      iconAssetPath: Assets.check_double_svg));
            }));
  }
}
