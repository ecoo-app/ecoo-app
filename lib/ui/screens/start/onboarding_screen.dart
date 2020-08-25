import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/flat_secondary_button.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

class OnboardingScreenArguments {
  final bool canBack;

  OnboardingScreenArguments(this.canBack);
}

@injectable
class OnboardingScreen extends StatefulWidget {
  final OnboardingScreenViewModel viewModel;

  const OnboardingScreen(this.viewModel);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();

  List<Widget> _pageList = [];
  double _currentPage = 0.0;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
        _isLastPage = _currentPage > 2.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    OnboardingScreenArguments arguments =
        ModalRoute.of(context).settings.arguments as OnboardingScreenArguments;

    bool canBack = false;
    if (arguments != null) {
      canBack = arguments.canBack;
    }

    _pageList = [
      OnboardingPageWidget(
        title: I18n.of(context).page1TitleOnboardingScreen,
        headline: I18n.of(context).page1HeadlineOnboardingScreen,
        description: I18n.of(context).page1DescriptionOnboardingScreen,
        headerIconAsset: Assets.icon_arrow_right_svg,
        headerIconBackgroundAsset:
            Assets.onboarding_background_graphic_private_svg,
      ),
      OnboardingPageWidget(
        title: I18n.of(context).page2TitleOnboardingScreen,
        headline: I18n.of(context).page2HeadlineOnboardingScreen,
        description: I18n.of(context).page2DescriptionOnboardingScreen,
        headerIconAsset: Assets.onboarding_icon_wallet_svg,
        headerIconBackgroundAsset:
            Assets.onboarding_background_graphic_private_svg,
      ),
      OnboardingPageWidget(
        title: I18n.of(context).page3TitleOnboardingScreen,
        headline: I18n.of(context).page3HeadlineOnboardingScreen,
        description: I18n.of(context).page3DescriptionOnboardingScreen,
        headerIconAsset: Assets.onboarding_icon_shop_svg,
        headerIconBackgroundAsset:
            Assets.onboarding_background_graphic_shop_svg,
      ),
      OnboardingPageWidget(
        title: I18n.of(context).page4TitleOnboardingScreen,
        headline: I18n.of(context).page4HeadlineOnboardingScreen,
        description: I18n.of(context).page4DescriptionOnboardingScreen,
        headerIconAsset: Assets.onboarding_icon_shop_arrows_svg,
        headerIconBackgroundAsset:
            Assets.onboarding_background_graphic_shop_svg,
      ),
    ];

    var buttonText = I18n.of(context).buttonTextSkipOnboardingScreen;
    if (_isLastPage) {
      buttonText = I18n.of(context).buttonTextNextOnboardingScreen;
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              PageView(
                controller: _pageController,
                children: _pageList,
              ),
              canBack
                  ? Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: CustomHeader(
                        closeIcon: Assets.close_svg,
                        closeIconColor: ColorStyles.white,
                        onClose: () => Navigator.of(context).pop(),
                      ),
                    )
                  : SizedBox.shrink(),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 28,
                  child: _pageIndicator(),
                ),
              ),
              canBack
                  ? SizedBox.shrink()
                  : _isLastPage
                      ? _getRegistrationButton(buttonText)
                      : _getSkipButton(buttonText)
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRegistrationButton(buttonText) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(
          bottom: 70,
          left: LayoutStyles.spacing_m,
          right: LayoutStyles.spacing_m),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: OutlinedSecondaryButton(
          svgAsset: Assets.icon_leaf_svg,
          text: buttonText,
          textColor: ColorStyles.black,
          outlineColor: ColorStyles.bg_gray,
          onPressed: widget.viewModel.complete,
        ),
      ),
    );
  }

  Widget _getSkipButton(String buttonText) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(
          bottom: 70,
          left: LayoutStyles.spacing_m,
          right: LayoutStyles.spacing_m),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: FlatSecondaryButton(
          text: buttonText,
          textColor: ColorStyles.purple,
          onPressed: () => widget.viewModel.complete(),
        ),
      ),
    );
  }

  Widget _pageIndicator() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(_pageList.length, (index) => _indicator(index)));
  }

  Widget _indicator(int position) {
    return Container(
      height: 12,
      width: 12,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage.round() == position
              ? ColorStyles.black
              : ColorStyles.bg_transparent),
    );
  }
}

class OnboardingPageWidget extends StatelessWidget {
  final String title;
  final String headline;
  final String description;
  final String headerIconAsset;
  final String headerIconBackgroundAsset;

  const OnboardingPageWidget({
    Key key,
    this.title,
    this.headline,
    this.description,
    this.headerIconAsset,
    this.headerIconBackgroundAsset,
  }) : super(key: key);

  TextStyle colorStylesTitleWhite(BuildContext context) {
    return Theme.of(context).textTheme.headline2.merge(TextStyle(
          color: ColorStyles.black,
          fontWeight: fontWeightBold,
        ));
  }

  TextStyle colorStylesHeadlineWhite(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline3
        .merge(TextStyle(color: ColorStyles.black, fontSize: 20.0));
  }

  TextStyle colorStylesDescriptionWhite(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        .merge(TextStyle(color: ColorStyles.black));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 135),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 60),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    SvgPicture.asset(
                      headerIconBackgroundAsset,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: SvgPicture.asset(headerIconAsset,
                          color: ColorStyles.white),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: 6,
                      left: LayoutStyles.spacing_m,
                      right: LayoutStyles.spacing_m),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: colorStylesTitleWhite(context),
                  )),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: 52,
                      left: LayoutStyles.spacing_m,
                      right: LayoutStyles.spacing_m),
                  child: Text(
                    headline,
                    textAlign: TextAlign.left,
                    style: colorStylesHeadlineWhite(context),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 14,
                      left: LayoutStyles.spacing_m,
                      right: LayoutStyles.spacing_m),
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: colorStylesDescriptionWhite(context),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
