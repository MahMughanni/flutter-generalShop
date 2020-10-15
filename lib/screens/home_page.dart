import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        color: Colors.teal,
      ),
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
