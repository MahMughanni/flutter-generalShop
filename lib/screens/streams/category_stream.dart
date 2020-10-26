import 'dart:async';

import 'package:flutter_generalshop/api/helpers_api.dart';
import 'package:flutter_generalshop/contracts/contracts.dart';
import 'package:flutter_generalshop/product/product_category.dart';

class CategoriesStream implements Disposable {
  List<ProductCategory> categories;

  StreamController<List<ProductCategory>> _categoriesController = StreamController<List<ProductCategory>>.broadcast();

  Stream<List<ProductCategory>> get categoriesStream => _categoriesController.stream;

  StreamSink<List<ProductCategory>> get categorySink =>
      _categoriesController.sink;
  HelperAPi helperAPi = HelperAPi();

  CategoriesStream() {
    categories = [];
    _categoriesController.add(categories);
    _categoriesController.stream.listen(fetchCategories);
  }

  Future<void> fetchCategories(List<ProductCategory> categories) async {
    categories = await helperAPi.fetchCategories();
    _categoriesController.add(categories);
  }

  @override
  void dispose() {
    _categoriesController.close();
  }
}
