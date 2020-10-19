import 'dart:convert';

import 'package:flutter_generalshop/api/api_utl.dart';
import 'package:flutter_generalshop/exceptions/exceptions.dart';
import 'package:flutter_generalshop/product/product.dart';
import 'package:http/http.dart' as http;

class ProductsAPI {
  Future<List<Product>> fetchProducts(int page) async {
    await checkInternet();
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

  Future<List<Product>> fetchProductsByCategory(
      int categoryId, int page) async {
    await checkInternet();
    String url = APiUtl.CATEGORY_PRODUCTS(categoryId, page);

    Map<String, String> headers = {'Accept': 'application/json'};
    http.Response response = await http.get(url, headers: headers);
    switch (response.statusCode) {
      case 404:
        break;
      case 302:
      case 301:
      case 303:
        throw RedirectionFound();
        break;
      case 200:
        List<Product> products = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          print(item);

          products.add(Product.fromJson(item));

          return products;
        }
        break;

      default:
        return null;
        break;
    }
  }
}
