import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/onboarding/onboarding_model.dart';
import 'package:flutter_generalshop/screens/onboarding/single_onboarding_screen.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController;
  int currentIndex = 0;
  double screenHeight;
  bool lastPage = false;

  double screenWidth;

  List<OnBoardingModel> boardingList = [
    OnBoardingModel(
      image: 'assets/images/board1.png',
      title: 'Welcome!',
      description: 'Now we Are in the big leagues getting our turn at back , ',
    ),
    OnBoardingModel(
      image: 'assets/images/board3.jpg',
      title: 'Add To Cart',
      description: 'Now we Are in the big leagues getting our turn at back ,',
    ),
    OnBoardingModel(
      image: 'assets/images/board2.jpg',
      title: 'Enjoy Purchase',
      description: 'Now we Are in the big leagues getting our turn at back ,',
    ),
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
    double marginTop = MediaQuery.of(context).size.height * 0.15;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: marginTop),
        child: Column(
          children: [
            Flexible(
              child: Container(
                color: Colors.white,
                height: screenHeight,
                width: screenWidth,
                child: PageView.builder(
                  itemBuilder: (BuildContext context, int position) {
                    return SingleOnBoardingScreen(boardingList[position]);
                  },
                  itemCount: boardingList.length,
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                      if (index == (boardingList.length - 1)) {
                        lastPage = true;
                      } else {
                        lastPage = false;
                      }
                    });
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -(marginTop)),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _drawDots(boardingList.length),
                ),
              ),
            ),
            (lastPage) ? _showButton() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _showButton() {
    return Container(
      child: Transform.translate(
        offset: Offset(0, -(screenHeight * .05)),
        child: SizedBox(
          width: screenWidth * 0.75,
          height: 50,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            onPressed: () {},
            child: Text(
              'Get start',
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            color: ScreenUtilities.mainBlue,
          ),
        ),
      ),
    );
  }

  List<Widget> _drawDots(int qty) {
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: (i == currentIndex)
              ? ScreenUtilities.mainBlue
              : ScreenUtilities.lightGray,
        ),
        width: 30,
        height: 5,
        margin: (i == qty - 1)
            ? EdgeInsets.only(right: 0)
            : EdgeInsets.only(right: 20),
      ));
    }

    return widgets;
  }
}
