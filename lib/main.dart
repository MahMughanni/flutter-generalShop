import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/home_page.dart';
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

      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: ScreenUtilities.appBarTitle ,
            )
          )
      ),
    );
  }
}
