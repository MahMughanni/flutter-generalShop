import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/onboarding/onboarding_model.dart';
import 'package:flutter_generalshop/screens/onboarding/single_onboarding_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController;

  List<OnBoardingModel> boardingList = [
    OnBoardingModel(
        image: 'assets/images/board1.svg', title: 'Welcome', description: ''),
    OnBoardingModel(
        image: 'assets/images/board2.jpg', title: 'Welcome', description: ''),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: PageView.builder(
          itemBuilder: (BuildContext context, int position) {
            return SingleOnBoardingScreen(boardingList[position]);
          },
          itemCount: boardingList.length,
          controller: _pageController,
        ),
      ),
    );
  }
}
