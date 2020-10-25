import 'dart:async';
import 'package:flutter_generalshop/api/products_api.dart';
import 'package:flutter_generalshop/contracts/contracts.dart';
import 'package:flutter_generalshop/product/product.dart';

class HomeProductBloc implements Disposable {
  List<Product> productList;
  ProductsAPI productsAPI;

  int categoryID;

  final StreamController<int> _categoryController =
      StreamController<int>.broadcast();

  final StreamController<List<Product>> _productController =
      StreamController<List<Product>>.broadcast();

  Stream<List<Product>> get productsStream => _productController.stream;

  StreamSink<int> get fetchProducts => _categoryController.sink;

  Stream<int> get categoryStream => _categoryController.stream;

  HomeProductBloc() {
    this.productList = [];
    productsAPI = ProductsAPI();
    _productController.add(this.productList);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(_fetchCategoryFromAPi);
  }

  Future<void> _fetchCategoryFromAPi(int categoryId ) async {
    this.productList = await productsAPI.fetchProductsByCategory(categoryId, 1);
    _productController.add(this.productList);
  }

  @override
  void dispose() {
    _productController.close();
    _categoryController.close();
  }
}
