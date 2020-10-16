import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/home_page.dart';
import 'package:flutter_generalshop/screens/onboarding/onboarding_model.dart';
import 'package:flutter_generalshop/screens/onboarding/single_onboarding_screen.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController;
  int currentIndex = 0;
  double screenHeight;
  bool lastPage = false;
  ScreenConfig screenConfig;

  WidgetSize widgetSize;

  double screenWidth;

  List<OnBoardingModel> boardingList = [
    OnBoardingModel(
      image: 'assets/images/board1.jpg',
      title: 'Welcome!',
      description: 'Now we Are in the big leagues getting our turn at back , ',
    ),
    OnBoardingModel(
      image: 'assets/images/board3.jpg',
      title: 'Add To Cart',
      description: 'Now we Are in the big leagues getting our turn at back ,',
    ),
    OnBoardingModel(
      image: 'assets/images/board4.png',
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

    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);

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
    double offset = (screenConfig.screenType == ScreenType.SMALL) ? 0.05 : 0.1;
    return Container(
      child: Transform.translate(
        offset: Offset(0, -(screenHeight * offset)),
        child: SizedBox(
          width: screenWidth * 0.75,
          height: widgetSize.buttonHeight,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              pref.setBool('is_seen', true);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())
              );
            },
            child: Text(
              'Get start',
              style: TextStyle(
                  fontSize: widgetSize.buttonFontSize,
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
        width: widgetSize.pagerDotsWidth,
        height: widgetSize.pagerDotsHeight,
        margin: (i == qty - 1)
            ? EdgeInsets.only(right: 0)
            : EdgeInsets.only(right: 20),
      ));
    }

    return widgets;
  }
}
