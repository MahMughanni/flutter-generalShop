import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/products_api.dart';
import 'package:flutter_generalshop/product/product.dart';
import 'package:flutter_generalshop/screens/home_page.dart';
import 'package:flutter_generalshop/screens/login.dart';
import 'package:flutter_generalshop/screens/onboarding/onbording.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  //fixed accessed before the binding was initialized .
  WidgetsFlutterBinding.ensureInitialized();
  //
  var pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  Widget homePage = HomePage();
  if (isSeen == null || !isSeen) {
    homePage = OnBoarding();
  }
  runApp(GeneralShop(homePage));
}

class GeneralShop extends StatelessWidget {
  final Widget homePage;

  GeneralShop(this.homePage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (_) => new LogInScreen(),
      },
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryIconTheme: IconThemeData(
          color: Colors.grey.shade900,
        ),
        textTheme: TextTheme(
          headline: TextStyle(
              color: ScreenUtilities.appBarTitle,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 16),
          subhead: TextStyle(
              color: ScreenUtilities.appBarTitle,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 14),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          textTheme: TextTheme(
            headline6: TextStyle(
                color: ScreenUtilities.appBarTitle,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                fontSize: 22),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: ScreenUtilities.mainBlue),
        tabBarTheme: TabBarTheme(
            labelColor: ScreenUtilities.appBarTitle,
            labelStyle: TextStyle(
                fontFamily: "Quicksand",
                fontSize: 19,
                fontWeight: FontWeight.w700),
            labelPadding: EdgeInsets.all(16),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: ScreenUtilities.unselected),
        indicatorColor: ScreenUtilities.mainBlue,
      ),
    );
  }
}
