import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/helpers_api.dart';
import 'package:flutter_generalshop/product/product_category.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  HelperAPi helperAPi = HelperAPi();

  TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    return FutureBuilder(
      future: helperAPi.fetchCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ProductCategory>> snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.none:
            return _error('No Connection made');
            break;
          case ConnectionState.waiting:
          case ConnectionState.active:
            return _loading();
            break;
          case ConnectionState.done:
            if (snapShot.hasError) {
              return _error(snapShot.error.toString());
            } else {
              if (!snapShot.hasData) {
                return _error("No data founded");
              } else {
                return _screen(snapShot.data);
              }
            }
            break;
        }
        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories) {
    tabController = TabController(
      initialIndex: 0,
      vsync: this,
      length: categories.length,
    );

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Home',
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ))
        ],
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
        ),
      ),
      body: Container(),
    );
  }
}

List<Tab> _tabs(List<ProductCategory> categories) {
  List<Tab> tabsList = [];
  for (ProductCategory category in categories) {
    tabsList.add(Tab(
      text: category.category_name,
    ));
  }
  return tabsList;
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
