import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/rhombus_button.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:e_coupon/ui/screens/register/register_scaffold.dart';
import 'package:e_coupon/ui/screens/register/wallet_selection_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

class WalletSelectionScreenArguments {
  final bool canClose;

  WalletSelectionScreenArguments({this.canClose = true});
}

@injectable
class WalletSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments
        as WalletSelectionScreenArguments;
    bool canClose = true;
    if (arguments != null) {
      canClose = arguments.canClose;
    }

    return BaseView<WalletSelectionScreenViewModel>(
      model: getIt<WalletSelectionScreenViewModel>(),
      builder: (context, model, child) {
        if (model.viewState is Error) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Error error = model.viewState;
            ErrorToast(failure: error.failure).create(context)..show(context);
          });
        }

        var isLoading = (model.viewState is Loading);

        return RegisterScaffold(
          title: I18n.of(context).titleRegisterWalletTypeScreen,
          subhead: Text(
            I18n.of(context).descriptionRegisterWalletTypeScreen,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          header: canClose
              ? CustomHeader(
                  closeIcon: Assets.close_svg,
                  onClose: model.back,
                )
              : SizedBox.fromSize(
                  size: Size(0, 55),
                ),
          content: Stack(
            children: [
              isLoading
                  ? Center(child: ECProgressIndicator())
                  : SizedBox.shrink(),
              Column(
                children: <Widget>[
                  RhombusButton(
                    text: I18n.of(context).privateRegisterWalletTypeScreen,
                    private: true,
                    onTap: isLoading ? null : model.privateWalletSelected,
                  ),
                  RhombusButton(
                    text: I18n.of(context).shopRegisterWalletTypeScreen,
                    private: false,
                    onTap: isLoading ? null : model.shopWalletSelected,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
