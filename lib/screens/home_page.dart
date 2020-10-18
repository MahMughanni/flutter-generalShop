import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/helpers_api.dart';
import 'package:flutter_generalshop/product/home_product.dart';
import 'package:flutter_generalshop/product/product.dart';
import 'package:flutter_generalshop/product/product_category.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  HelperAPi helperAPi = HelperAPi();
  HomeProductBloc homeProductBloc = HomeProductBloc();
  List<ProductCategory> categoryList;

  TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
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
            return _loading();
            break;

          case ConnectionState.active:
            _loading();
            break ;
          case ConnectionState.done:
            if (snapShot.hasError) {
              return _error(snapShot.error.toString());
            } else {
              if (!snapShot.hasData) {
                return _error("No data founded");
              } else {
                this.categoryList = snapShot.data;
                homeProductBloc.categoryIDSink
                    .add(this.categoryList[0].category_id);
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
          onTap: (int index) {
            homeProductBloc.categoryIDSink.add(categoryList[index].category_id);
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: homeProductBloc.productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _error("noting working");
                break;
              case ConnectionState.waiting:
                return _loading();
                break;
              case ConnectionState.done:
              case ConnectionState.active:
                if (snapshot.hasError) {
                  return _error(snapshot.error.toString());
                } else {
                  if (!snapshot.hasData) {
                    return _error("no data return");
                  } else {
                    return _drawProducts(snapshot.data);
                  }
                }
                break;
            }
            return Container();
          },
        ),
      ),
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

Widget _drawProducts(List<Product> products) {
  return Container(
      child: Column(
    children: [
      Flexible(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, position) {
              return Card(
                child: Container(
                  child: Image(
                    image: NetworkImage(products[position].featuredImage()),
                  ),
                ),
              );
            }),
      ),
    ],
  ));
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
