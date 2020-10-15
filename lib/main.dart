import 'package:flutter/material.dart';
import 'package:flutter_generalshop/screens/home_page.dart';

void main() {
  runApp(GeneralShop());
}

class GeneralShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
