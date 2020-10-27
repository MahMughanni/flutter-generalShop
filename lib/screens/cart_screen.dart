import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/cart/cart.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';

import 'details_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartApi cartApi = CartApi();
  bool loading = false;
  WidgetSize widgetSize;
  ScreenConfig screenConfig;
  double screenHeight;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: Text('Cart'),
        ),
      ),
      body: FutureBuilder(
        future: cartApi.fetchCart(),
        builder: (context, AsyncSnapshot<Cart> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('error');
              } else {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          itemCount: snapshot.data.cartItems.length,
                          itemBuilder: (context, int position) {
                            return _drawProductRow(
                                snapshot.data.cartItems[position], context);
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                      //   child: Container(
                      //     width: screenWidth * 0.75,
                      //     height: widgetSize.buttonHeight,
                      //     child: RaisedButton(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: Text(
                      //         'Checkout All',
                      //         style: TextStyle(
                      //             fontSize: widgetSize.buttonFontSize,
                      //             letterSpacing: 1,
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.normal),
                      //       ),
                      //       color: ScreenUtilities.mainBlue,
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => CheckoutScreen(
                      //                     )));
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                } else {
                  return Text('no data');
                }
              }
              break;

            default:
              return Container();

              break;
          }
        },
      ),
    );
  }

  Widget _drawProductRow(CartItem cartItem, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          NetworkImage(cartItem.product.featuredImage()))),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(cartItem.product.product_title),
                      Text(cartItem.product.productCategory.category_name),
                      Text(cartItem.product.product_price.toString()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              await cartApi.removeProductFromCart(
                                  cartItem.product.product_id);
                              setState(() {
                                loading = false;
                              });
                            },
                          ),
                          Text(cartItem.qty.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              await cartApi.addProductToCart(
                                  cartItem.product.product_id);
                              setState(() {
                                loading = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    _goToSingleProduct(cartItem, context);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _goToSingleProduct(CartItem cartItem, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return CheckoutScreen(cartItem: cartItem);
  }));
}
