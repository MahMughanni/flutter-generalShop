import 'package:flutter/cupertino.dart';

enum ScreenType {
  SMALL,
  MEDIUM,
  LARGE,
}

class ScreenConfig {
  BuildContext context;

  double screenWidth;
  ScreenType screenType;
  double screenHigh;

  ScreenConfig(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;
    _setScreen();
  }

  void _setScreen() {
    if (this.screenWidth >= 320 && this.screenWidth < 375) {
      this.screenType = ScreenType.SMALL;
    }
    if (this.screenWidth >= 375 && this.screenWidth < 414) {
      this.screenType = ScreenType.MEDIUM;
    }
    if (this.screenWidth >= 414) {
      this.screenType = ScreenType.LARGE;
    }
  }
}

class WidgetSize {
  double titleFontSize;

  double descriptionFontSize;
  double pagerDotsWidth;

  double pagerDotsHeight;

  ScreenConfig screenConfig;
  double buttonHeight;

  double buttonFontSize;

  WidgetSize(ScreenConfig screenConfig) {
    this.screenConfig = screenConfig;
    _init();
  }

  void _init() {
    switch (this.screenConfig.screenType) {
      case ScreenType.SMALL:
        this.titleFontSize = 20;
        this.descriptionFontSize = 15;
        this.pagerDotsHeight = 4;
        this.pagerDotsWidth = 24;
        this.buttonHeight = 40;
        this.buttonFontSize = 17;

        break;

      case ScreenType.MEDIUM:
        this.titleFontSize = 26;
        this.descriptionFontSize = 20;
        this.pagerDotsHeight = 5;
        this.pagerDotsWidth = 30;
        this.buttonHeight = 50;
        this.buttonFontSize = 20;

        break;

      case ScreenType.LARGE:
        this.titleFontSize = 26;
        this.descriptionFontSize = 20;
        this.pagerDotsHeight = 5;
        this.pagerDotsWidth = 30;
        this.buttonHeight = 50;
        this.buttonFontSize = 20;

        break;

      default:
        this.titleFontSize = 26;
        this.descriptionFontSize = 20;
        this.pagerDotsHeight = 5;
        this.pagerDotsWidth = 30;
        this.buttonHeight = 50;
        this.buttonFontSize = 20;

        break;
    }
  }
}
