import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/cart/cart.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';

class CheckoutScreen extends StatefulWidget {
  final CartItem cartItem;

  CheckoutScreen({this.cartItem});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CartApi cartApi = CartApi();
  WidgetSize widgetSize;
  ScreenConfig screenConfig;
  double screenHeight;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextStyle textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(

          elevation: .3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.w300, letterSpacing: .5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image(
                    fit: BoxFit.cover,
                    image:
                        ExactAssetImage('assets/images/visa_credit_card.png'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price of unit',
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w300),
                          ),
                          Text(
                              '\$' +
                                  widget.cartItem.product.product_price
                                      .toString(),
                              style: textStyle),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w300),
                          ),
                          Text(
                              '\%' +
                                  widget.cartItem.product.product_discount
                                      .toString(),
                              style: textStyle),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping',
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w300),
                          ),
                          Text('\$10', style: textStyle),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, right: 32),
                      color: Colors.grey,
                      width: double.infinity,
                      height: .5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text('\$' + total(), style: textStyle),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Container(
                    width: screenWidth * 0.80,
                    height: widgetSize.buttonHeight,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Checkout All',
                        style: TextStyle(
                            fontSize: widgetSize.buttonFontSize,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      color: ScreenUtilities.mainBlue,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String total() {
    double price = widget.cartItem.product.product_price;
    double qty = widget.cartItem.qty;
    double shipping = 10.0;
    return (shipping + (price * qty)).toString();
  }
}
