import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/cart/cart.dart';
import 'package:provider/provider.dart';

class CartTest extends StatefulWidget {
  @override
  _CartTestState createState() => _CartTestState();
}

class _CartTestState extends State<CartTest> {
  CartApi cartApi = CartApi();

  @override
  Widget build(BuildContext context) {
    // var count = Provider.of<Cart>(context, listen: false);
    var co = Provider.of<CartApi>(context, listen: false);

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
                  return ListView.builder(
                    itemCount: snapshot.data.cartItems.length,
                    itemBuilder: (context, int position) {
// List<CartItem> cartItem = snapshot.data.cartItems ;

                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data.cartItems[position]
                                                .product
                                                .featuredImage()),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () async {
                                    co.removeProductFromCart(snapshot
                                        .data
                                        .cartItems[position]
                                        .product
                                        .product_id);
                                    // cartApi.removeProductFromCart();
                                  },
                                ),

                                // Text(snapshot.data.cartItems[position].qty
                                //     .toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () async {
                                    co.addProductToCart(snapshot
                                        .data
                                        .cartItems[position]
                                        .product
                                        .product_id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
          return Container();
        },
      ),
    );
  }

  Widget _drawProductRow(CartItem cartItem, BuildContext context) {
    var count = Provider.of<CartItem>(context, listen: true);
    var co = Provider.of<CartApi>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(cartItem.product.featuredImage()),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  co.removeProductFromCart(cartItem.product.product_id);
                  // cartApi.removeProductFromCart();
                },
              ),
              // Text(cartItem.qty.toString()),
              Text(cartItem.qty.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  co.addProductToCart(cartItem.product.product_id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
