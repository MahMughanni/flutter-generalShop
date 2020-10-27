import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/product/product.dart';
import 'package:flutter_generalshop/screens/login.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_screen.dart';
import 'home_page.dart';

class SingleProduct extends StatefulWidget {
  final Product product;

  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  CartApi cartApi = CartApi();
  bool _addToCart = false;

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text(widget.product.product_title),
      ),
      body: _drawScreen(context),
      floatingActionButton: FloatingActionButton(
        child: (_addToCart)
            ? CircularProgressIndicator()
            : Icon(Icons.add_shopping_cart),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          int userID = pref.getInt('user_id');
          if (userID == null) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            setState(() {
              _addToCart = true;
            });
            await cartApi.addProductToCart(widget.product.product_id);
            setState(() {
              _addToCart = false;
            });
          }
        },
      ),
    );
  }

  Widget _drawScreen(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * .30,
                child: _drawImageView(context)),
            _drawTitle(context),
            _drawDetails(context),
          ],
        ),
      ),
      _drawLine(),
    ]);
  }

  Widget _drawImageView(BuildContext context) {
    return PageView.builder(
        itemCount: widget.product.productImages.length,
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image(
                loadingBuilder:
                    (context, image, ImageChunkEvent progressLoading) {
                  if (progressLoading == null) {
                    return image;
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                fit: BoxFit.cover,
                image: NetworkImage(widget.product.productImages[position]),
              ),
            ),
          );
        });
  }

  Widget _drawTitle(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 16.0, right: 16, left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.product_title,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.product.productCategory.category_name,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$' + widget.product.product_price.toString()),
                  SizedBox(
                    height: 16,
                  ),
                  (widget.product.product_discount > 0)
                      ? Text('\$' + _calculateDiscount())
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawDetails(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Descriptions',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                widget.product.product_description,
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1,
                    height: 1.5,
                    color: Colors.grey.shade600),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _calculateDiscount() {
    double discount = widget.product.product_discount;
    double price = widget.product.product_price;

    return (price * discount).toString();
  }

  Widget _drawLine() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0, -40),
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 16),
          height: 1,
          color: ScreenUtilities.lightGray,
        ),
      ),
    );
  }
}
