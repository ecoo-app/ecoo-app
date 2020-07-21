import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnboardingScreen extends StatelessWidget {
  final OnboardingScreenViewModel viewModel;

  const OnboardingScreen(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Text('Onboarding')),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: PrimaryButton(
                  text: 'Einführung überspringen',
                  onPressed: () => viewModel.complete(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
