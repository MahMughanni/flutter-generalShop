import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/cart/cart.dart';

class CheckoutScreen extends StatefulWidget {
  final CartItem cartItem;

  CheckoutScreen({this.cartItem});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CartApi cartApi = CartApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: Text('Checkout Single Product'),
        ),
      ),
      body: Column(
        children: [
          Image(
            fit: BoxFit.cover,
            image: ExactAssetImage('assets/images/visa_credit_card.png'),
          ),
          SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8, right: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Subtotal'),
                    Text(total()),
                    // Text(widget.cartItem.product.product_price.toString())
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String total() {
    double price = widget.cartItem.product.product_price;
    double qty = widget.cartItem.qty;
    return (price * qty).toString();
  }
}
