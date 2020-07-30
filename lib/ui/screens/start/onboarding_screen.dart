import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

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
  bool _isShopOnboardingPage = false;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
        _isShopOnboardingPage = _currentPage > 1.5;
        _isLastPage = _currentPage > 2.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _pageList = [
      OnboardingPageWidget(
        title: I18n.of(context).page1TitleOnboardingScreen,
        headline: I18n.of(context).page1HeadlineOnboardingScreen,
        description: I18n.of(context).page1DescriptionOnboardingScreen,
      ),
      OnboardingPageWidget(
        title: I18n.of(context).page2TitleOnboardingScreen,
        headline: I18n.of(context).page2HeadlineOnboardingScreen,
        description: I18n.of(context).page2DescriptionOnboardingScreen,
      ),
      OnboardingPageWidget(
        title: I18n.of(context).page3TitleOnboardingScreen,
        headline: I18n.of(context).page3HeadlineOnboardingScreen,
        description: I18n.of(context).page3DescriptionOnboardingScreen,
      ),
      OnboardingPageWidget(
        title: I18n.of(context).page4TitleOnboardingScreen,
        headline: I18n.of(context).page4HeadlineOnboardingScreen,
        description: I18n.of(context).page4DescriptionOnboardingScreen,
      ),
    ];

    var buttonText = I18n.of(context).buttonTextSkipOnboardingScreen;
    if (_isLastPage) {
      buttonText = I18n.of(context).buttonTextNexOnboardingScreen;
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
              gradient: _isShopOnboardingPage
                  ? GradientStyles.shopWalletBackgroundGradient
                  : GradientStyles.privateWalletBackgroundGradient),
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              PageView(
                controller: _pageController,
                children: _pageList,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 190),
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 28,
                  child: _pageIndicator(),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(
                    bottom: 58,
                    left: LayoutStyles.spacing_m,
                    right: LayoutStyles.spacing_m),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: OutlineButton(
                    padding: const EdgeInsets.symmetric(vertical: 23),
                    borderSide: const BorderSide(color: ColorStyles.white),
                    highlightedBorderColor: ColorStyles.bg_light_gray,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      buttonText,
                      style: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: ColorStyles.white,
                              fontWeight: fontWeightRegular)),
                    ),
                    onPressed: () => widget.viewModel.complete(),
                  ),
                ),
              )
            ],
          ),
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
              ? ColorStyles.white
              : ColorStyles.bg_transparent),
    );
  }
}

class OnboardingPageWidget extends StatelessWidget {
  final String title;
  final String headline;
  final String description;

  const OnboardingPageWidget(
      {Key key, this.title, this.headline, this.description})
      : super(key: key);

  TextStyle colorStylesTitleWhite(BuildContext context) {
    return Theme.of(context).textTheme.headline2.merge(TextStyle(
          color: ColorStyles.white,
          fontWeight: fontWeightBold,
        ));
  }

  TextStyle colorStylesHeadlineWhite(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline3
        .merge(TextStyle(color: ColorStyles.white, fontSize: 20.0));
  }

  TextStyle colorStylesDescriptionWhite(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        .merge(TextStyle(color: ColorStyles.white));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 240),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 80),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    SvgPicture.asset(
                      Assets.onboarding_background_graphic_svg,
                      color: ColorStyles.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: SvgPicture.asset(
                        Assets.onboarding_icon_background_svg,
                        color: ColorStyles.white,
                      ),
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
