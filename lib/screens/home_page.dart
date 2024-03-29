import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/helpers_api.dart';
import 'package:flutter_generalshop/product/home_product.dart';
import 'package:flutter_generalshop/product/product.dart';
import 'package:flutter_generalshop/product/product_category.dart';
import 'package:flutter_generalshop/screens/cart_test.dart';
import 'package:flutter_generalshop/screens/single_product.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';

import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  HelperAPi helperAPi = HelperAPi();
  HomeProductBloc homeProductBloc = HomeProductBloc();
  List<ProductCategory> productsCategoriesList;
  PageController _pageController;
  WidgetSize widgetSize;

  TabController tabController;
  int currentIndex = 0;

  ValueNotifier dotsIndex = ValueNotifier(1);

  @override
  void initState() {
    _pageController = PageController(initialPage: 1, viewportFraction: 0.78);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextMain) {
    screenConfig = ScreenConfig(context);
    return FutureBuilder(
      future: helperAPi.fetchCategories(),
      builder: (contextMain, AsyncSnapshot<List<ProductCategory>> snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.none:
            return _error('No Connection made');
            break;

          case ConnectionState.waiting:
          case ConnectionState.active:
            _loading();

            break;
          case ConnectionState.done:
            if (snapShot.hasError) {
              return _error(snapShot.error.toString());
            } else {
              if (!snapShot.hasData) {
                return _error(" No data found");
              } else {
                this.productsCategoriesList = snapShot.data;
                homeProductBloc.fetchProducts
                    .add(this.productsCategoriesList[0].category_id);
                return _screen(snapShot.data, contextMain);
              }
            }
            break;
        }
        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories, BuildContext contextScreen) {
    tabController =
        TabController(initialIndex: 0, vsync: this, length: categories.length);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 150,
            ),
            ListTile(
              title: Text('Cart'),
              leading: Icon(Icons.shopping_cart),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contextScreen) => CartScreen()));
              },
            ),
            ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contextScreen) => HomePage()));
                }),
            ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.account_balance_wallet),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text('Language'),
                leading: Icon(Icons.language),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125),
        child: AppBar(
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
            indicatorWeight: 3,
            tabs: _tabs(categories),
            onTap: (int index) {
              homeProductBloc.fetchProducts
                  .add(this.productsCategoriesList[index].category_id);
            },
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: homeProductBloc.productsStream,
          builder: (contextScreen, AsyncSnapshot<List<Product>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _error("noting is working");
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
                    return _error('no Data ');
                  } else {
                    return _drawProducts(snapshot.data, contextScreen);
                  }
                }
                break;
            }
            return Container(
              color: Colors.indigoAccent,
              child: Text(
                'Done ',
                style: TextStyle(fontSize: 40),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _drawProducts(List<Product> products, BuildContext productsContext) {
    List<Product> topProducts = _randomTopProducts(products);
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Sell',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(productsContext).size.height * 0.25,
              child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: topProducts.length,
                  onPageChanged: (int index) {
                    dotsIndex.value = index;
                  },
                  itemBuilder: (productsContext, int position) {
                    return InkWell(
                      onTap: () {
                        _goToSingleProduct(
                            topProducts[position], productsContext);
                      },
                      child: Card(
                          color: Colors.grey.shade50,
                          margin: EdgeInsets.only(
                              right: 4, left: 4, bottom: 2, top: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            children: [
                              Container(
                                child: Image(
                                  loadingBuilder: (context, image,
                                      ImageChunkEvent progressLoading) {
                                    if (progressLoading == null) {
                                      return image;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  image: NetworkImage(
                                      topProducts[position].featuredImage()),
                                ),
                              ),
                            ],
                          )),
                    );
                  }),
            ),
            ValueListenableBuilder(
              valueListenable: dotsIndex,
              builder: (productsContext, value, _) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _drawDots(topProducts.length, value),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Products',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: 26, left: 4, right: 4),
                child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: .80),
                    itemBuilder: (productsContext, int position) {
                      return InkWell(
                        onTap: () {
                          _goToSingleProduct(
                              products[position], productsContext);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    shape: BoxShape.rectangle),
                                child: Image(
                                  loadingBuilder: (context, image,
                                      ImageChunkEvent progressLoading) {
                                    if (progressLoading == null) {
                                      return image;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  image: NetworkImage(
                                      products[position].featuredImage()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              products[position].product_title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                "\$ ${products[position].product_price.toString()}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> _drawDots(int qty, int index) {
  List<Widget> widgets = [];
  for (int i = 0; i < qty; i++) {
    widgets.add(Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color:
            (i == index) ? ScreenUtilities.mainBlue : ScreenUtilities.lightGray,
      ),
      width: 7,
      height: 7,
      margin: (i == qty - 1)
          ? EdgeInsets.only(right: 0)
          : EdgeInsets.only(right: 20),
    ));
  }

  return widgets;
}

//return just 5 products
List<Product> _randomTopProducts(List<Product> products) {
  List<int> indexes = [];
  Random random = Random();
  int counter = 5;
  List<Product> newProducts = [];
  do {
    int rnd = random.nextInt(products.length);
    if (!indexes.contains(rnd)) {
      indexes.add(rnd);
    }
    counter--;
  } while (counter != 0);

  for (int index in indexes) {
    newProducts.add(products[index]);
  }
  return newProducts;
}

List<Tab> _tabs(List<ProductCategory> categories) {
  List<Tab> tabsList = [];
  for (ProductCategory category in categories) {
    tabsList.add(Tab(
      child: Stack(
        children: [
          // Image(
          //   image: NetworkImage(category.image_url),
          // ),
          Text(category.category_name),
        ],
      ),
    ));
  }
  return tabsList;
}

_loading() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
        backgroundColor: Colors.deepPurple,
        strokeWidth: 1.3,
      ),
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

void _goToSingleProduct(Product product, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SingleProduct(product);
  }));
}
