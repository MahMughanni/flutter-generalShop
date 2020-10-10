import 'dart:convert';

import 'package:flutter_generalshop/api/api_utl.dart';
import 'package:flutter_generalshop/product/product.dart';
import 'package:http/http.dart' as http;

class ProductAPI {
  Future<List<Product>> fetchProducts(int page) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    String url = APiUtl.PRODUCTS + '?page=' + page.toString();

    http.Response response = await http.get(url, headers: headers);
    List<Product> products = [];

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        products.add(Product.fromJson(item));
      }
      return products;
    }
    return null;
  }
}
