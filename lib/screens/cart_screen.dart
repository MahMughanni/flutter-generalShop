import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/cart/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartApi cartApi = CartApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
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
                        return ListTile(
                          title: Text(
                            snapshot
                                .data.cartItems[position].product.product_title,
                          ),
                          trailing: Text(
                              snapshot.data.cartItems[position].qty.toString()),
                        );
                      });
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
}
