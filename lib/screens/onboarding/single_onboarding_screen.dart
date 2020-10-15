import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/onboarding/onboarding_model.dart';

class SingleOnBoardingScreen extends StatelessWidget {
  OnBoardingModel onBoardingModel;

  SingleOnBoardingScreen(this.onBoardingModel);

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                fontSize: 19,
                color: Colors.blueGrey,
                height: 1.4),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
