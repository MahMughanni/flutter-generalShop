import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenConfig screenConfig;

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    return Scaffold(
      appBar: AppBar(
        elevation: .1,
        title: Text(
          'Home',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.search,
              color: Colors.grey.shade900,
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}

_loading() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

_error(String error) {
  return Container(
    child: Center(
      child: Text(error),
    ),
  );
}
