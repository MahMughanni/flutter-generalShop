import 'package:flutter_generalshop/exceptions/exceptions.dart';

class ProductCategory {
  int category_id;
  String category_name;
  String image_url;


  ProductCategory(this.category_id, this.category_name,
      this.image_url);

  ProductCategory.fromJson(Map<String, dynamic> jsonObject) {

    assert( jsonObject['category_id'] != null, 'Category Id is null');
    assert( jsonObject['category_name'] != null, 'Category Name is null');
    assert( jsonObject['image_url'] != null, 'Image Url is null');

    if ( jsonObject['category_id'] == null) {
      throw PropertyIsRequired('Category ID');
    }
    if ( jsonObject['category_name'] == null) {
      throw PropertyIsRequired('Category Name ');
    }

    if ( jsonObject['image_url'] == null) {
      throw PropertyIsRequired('Image Url ');
    }

    this.category_id = jsonObject['category_id'];
    this.category_name = jsonObject['category_name'];
    this.image_url = jsonObject['image_url'];
  }
}
