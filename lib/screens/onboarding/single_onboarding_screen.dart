import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/onboarding/onboarding_model.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';

class SingleOnBoardingScreen extends StatelessWidget {
  OnBoardingModel onBoardingModel;

  SingleOnBoardingScreen(this.onBoardingModel);

  ScreenConfig screenConfig;
  WidgetSize widgetSize;

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.40,
          child: Image(
            image: ExactAssetImage(onBoardingModel.image),
          ),
        ),
        SizedBox(
          height: 22,
        ),
        Text(
          onBoardingModel.title,
          style: TextStyle(
              fontSize: widgetSize.titleFontSize, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Text(
            onBoardingModel.description,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: widgetSize.descriptionFontSize,
                color: Colors.blueGrey,
                height: 1.4),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
