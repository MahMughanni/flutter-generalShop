import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/cart/cart.dart';
import 'package:flutter_generalshop/product/product.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartApi cartApi = CartApi();
  bool loading = false;

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
                        return _drawProductRow(
                            snapshot.data.cartItems[position]);
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

  Widget _drawProductRow(CartItem cartItem) {
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
                  Text(cartItem.product.product_title),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  cartApi.removeProdcutFromCart(cartItem.product.product_id);
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
                  cartApi.addProductToCart(cartItem.product.product_id);
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
