import 'dart:async';

import 'package:flutter_generalshop/api/helpers_api.dart';
import 'package:flutter_generalshop/contracts/contracts.dart';
import 'package:flutter_generalshop/product/product.dart';

class HomeProductBloc implements Disposable {
  List<Product> productList;
  HelperAPi helperAPi;

  final StreamController<List<Product>> _productController =
      StreamController<List<Product>>.broadcast();

  final StreamController<int> _categoryController =
      StreamController<int>.broadcast();

  Stream<List<Product>> get productsStream => _productController.stream;

  Stream<int> get categoryStream => _categoryController.stream;

  StreamSink<int> get categoryIDSink => _categoryController.sink;

  int categoryID;

  HomeProductBloc() {
    // this.categoryID = categoryID;
    this.productList = [];
    helperAPi = HelperAPi();
    _productController.add(this.productList);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(fetchCategoryFromAPi);
  }

  Future<void> fetchCategoryFromAPi(int categoryId) async {
    this.productList = await helperAPi.fetchProductsByCategory(categoryId, 1);
    _productController.add(this.productList);
  }

  @override
  void dispose() {
    _productController.close();
    _categoryController.close();
  }
}
