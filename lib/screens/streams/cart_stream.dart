import 'dart:async';

import 'package:flutter_generalshop/api/api_utl.dart';
import 'package:flutter_generalshop/api/cart_api.dart';
import 'package:flutter_generalshop/api/helpers_api.dart';
import 'package:flutter_generalshop/cart/cart.dart';
import 'package:flutter_generalshop/contracts/contracts.dart';
import 'package:flutter_generalshop/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class CartStream implements Disposable {
  CartApi cartApi = CartApi();
  List<CartItem> carts;

  StreamController<List<CartItem>> _cartItemsController =
  StreamController<List<CartItem>>.broadcast();

  Stream<List<CartItem>> get cartStream => _cartItemsController.stream;

  StreamSink<List<CartItem>> get cartSink => _cartItemsController.sink;

  double qty;

  CartStream() {
    carts = [];
    _cartItemsController.add(carts);
  }



  @override
  void dispose() {
    _cartItemsController.close();
  }
}
