import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/onboarding/onboarding_model.dart';

class SingleOnBoardingScreen extends StatelessWidget {
  OnBoardingModel onBoardingModel ;

  SingleOnBoardingScreen(this.onBoardingModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: ExactAssetImage(onBoardingModel.image),),
        Text(onBoardingModel.title),
        Text(onBoardingModel.description) ,
      ],
    );
  }
}
