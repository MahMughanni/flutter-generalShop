import 'package:flutter_generalshop/product/product.dart';

class Cart {
  List<CartItem> cartItems;
  double total;
  int id;

  Cart(this.cartItems, this.total, this.id);

  Cart.fromJson(Map<String, dynamic> jsonObject) {
    this.total = jsonObject['total'];
    this.id = jsonObject['id'];

    cartItems = [];
    var items = jsonObject['cart_items'];
    for (var item in items) {
      cartItems.add(CartItem.fromJson(item));
    }
  }
}

class CartItem {
  Product product;

  double qty;

  CartItem(this.product, this.qty);

  CartItem.fromJson(Map<String, dynamic> jsonObject) {
    this.product = Product.fromJson(jsonObject['product']);
    this.qty = double.tryParse(jsonObject['qty']);
  }
}
