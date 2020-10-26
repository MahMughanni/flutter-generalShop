import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_generalshop/cart/cart.dart';
import 'package:flutter_generalshop/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_utl.dart';

class CartApi with ChangeNotifier {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<Cart> fetchCart() async {
    await checkInternet();

    String url = APiUtl.CART;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };

    http.Response response = await http.get(url, headers: authHeaders);
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        return Cart.fromJson(body);
        break;
      case 404:
        throw ResourceNotFound('Cart');
        break;
      case 500:
        throw Exceptions();
        break;
      case 422:
        throw UnProcessEntity();
        break;
      default:
        return null;
        break;
    }
  }

  Future<bool> addProductToCart(int productID) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');

    print(apiToken);

    String url = APiUtl.CART;

    Map<String, dynamic> body = {
      'product_id': productID.toString(),
      'qty': 1.toString(),
    };

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };

    http.Response response =
        await http.post(url, headers: authHeaders, body: body);
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
        notifyListeners();
        return true;
        break;
      case 404:
        throw ResourceNotFound('Cart');
        break;
      case 401:
        throw ResourceNotFound('token');
        break;
      case 422:
        throw UnProcessEntity();
        break;
      default:
        return null;
        break;
    }
  }

  Future<bool> removeProductFromCart(int productID) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');

    String url =
        APiUtl.REMOVE_FROM_CART + '/' + productID.toString() + '/remove';

    Map<String, dynamic> body = {
      'product_id': productID.toString(),
    };

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };

    http.Response response =
        await http.post(url, headers: authHeaders, body: body);
    print(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      case 404:
        throw ResourceNotFound('Cart');
        break; 
      case 401:
        throw ResourceNotFound('token');
        break;
      case 422:
        throw UnProcessEntity();
        break;
      default:
        return null;
        break;
    }
  }


}
