import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/screens/start/migration_check_item.dart';
import 'package:e_coupon/ui/screens/start/migration_check_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injectable/injectable.dart';

@injectable
class MigrationCheckScreen extends StatelessWidget {
  final MigrationCheckViewModel viewModel;
  MigrationCheckScreen(this.viewModel);

  String migrationStateText(
      BuildContext context, MigrationCheckItem migrationCheck) {
    switch (migrationCheck.state) {
      case MigrationStateEnum.WaitingForCheck:
        return I18n.of(context).migrationWaitingForCheck;
      case MigrationStateEnum.Checking:
        return I18n.of(context).migrationChecking;
      case MigrationStateEnum.Migrating:
        return I18n.of(context).migrationMigrating;
      case MigrationStateEnum.Done:
        return I18n.of(context).migrationDone;
      case MigrationStateEnum.Fail:
        return I18n.of(context).migrationFail;
      default:
        return I18n.of(context).migrationWaitingForCheck;
    }
  }

  Widget migrationStateWidget(MigrationCheckItem migrationCheck) {
    switch (migrationCheck.state) {
      case MigrationStateEnum.WaitingForCheck:
        return SvgPicture.asset(
          Assets.migration_waiting_svg,
          height: 28,
          width: 28,
        );
      case MigrationStateEnum.Checking:
        return Container(
          child: ECProgressIndicator(),
          height: 28,
          width: 28,
        );
      case MigrationStateEnum.Migrating:
        return Container(
          child: ECProgressIndicator(),
          height: 28,
          width: 28,
        );
      case MigrationStateEnum.Done:
        return SvgPicture.asset(
          Assets.migration_done_svg,
          height: 28,
          width: 28,
        );
      case MigrationStateEnum.Fail:
        return SvgPicture.asset(
          Assets.migration_fail_svg,
          height: 28,
          width: 28,
        );
      default:
        return SvgPicture.asset(
          Assets.migration_waiting_svg,
          height: 28,
          width: 28,
        );
    }
  }

  Widget createItem(MigrationCheckItem migrationCheck, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            migrationStateWidget(migrationCheck),
            SizedBox(
              width: 28,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    migrationCheck.walletID,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    migrationStateText(context, migrationCheck),
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: ColorStyles.bg_light_gray,
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BaseView<MigrationCheckViewModel>(
            model: viewModel,
            onModelReady: (model) => model.init(),
            builder: (context, model, child) {
              if (model.viewState is Error) {
                Error error = model.viewState;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ErrorToast(failure: error.failure).create(context)
                    ..show(context);
                });
              }
              return Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      I18n.of(context).migrationTitle,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28),
                    Text(
                      I18n.of(context).migrationText,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28),
                    StreamBuilder<List<MigrationCheckItem>>(
                      stream: viewModel.migrationItemsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 25),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var item = snapshot.data[index];
                                return createItem(item, context);
                              },
                            ),
                          );
                        } else {
                          // Empty State
                          return Container(
                            child: Center(
                              child: ECProgressIndicator(),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
