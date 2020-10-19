import 'package:flutter_generalshop/exceptions/exceptions.dart';
import 'package:flutter_generalshop/product/product_category.dart';
import 'package:flutter_generalshop/product/product_tags.dart';
import 'package:flutter_generalshop/product/product_unit.dart';
import 'package:flutter_generalshop/review/product_reviews.dart';

class Product {
  int product_id;
  String product_title, product_description;
  double product_total, product_price, product_discount;
  ProductUnit product_unit;
  ProductCategory productCategory;
  List<ProductTags> productTags;
  List<String> productImages;

  List<ProductReviews> productReviews;

  Product(
      this.product_id,
      this.product_title,
      this.product_description,
      this.product_total,
      this.product_price,
      this.product_discount,
      this.product_unit,
      this.productCategory,
      this.productTags,
      this.productImages,
      this.productReviews);

  Product.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['product_id'] != null, 'Product ID is null ');
    assert(jsonObject['product_title'] != null, 'Product Title is null ');
    assert(jsonObject['product_description'] != null,
        'Product Description is null ');
    assert(jsonObject['product_price'] != null, 'Product Price is null ');

    if (jsonObject['product_id'] == null) {
      throw PropertyIsRequired('Product ID');
    }
    if (jsonObject['product_title'] == null) {
      throw PropertyIsRequired('Product Title ');
    }
    if (jsonObject['product_description'] == null) {
      throw PropertyIsRequired('Product Description');
    }
    if (jsonObject['product_price'] == null) {
      throw PropertyIsRequired('Product Price ');
    }

    this.product_id = jsonObject['product_id'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_unit = ProductUnit.fromJson(jsonObject['product_unit']);
    this.product_total = double.tryParse(jsonObject['product_total']);
    this.product_price = double.tryParse(jsonObject['product_price']);
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);
    _setTags(jsonObject['product_tags']);

    productImages = [];
    if (jsonObject['product_images'] != null) {
      _setImages(jsonObject['product_images']);
    }

    this.productReviews = [];
    if (jsonObject['product_reviews'] != null) {
      _setReview(jsonObject['product_reviews']);
    }
  }

  void _setTags(List<dynamic> tagsJson) {
    productTags = [];
    if (tagsJson.length > 0) {
      for (var item in tagsJson) {
        if (item != null) {
          productTags.add(ProductTags.fromJson(item));
        }
      }
    }
  }

  void _setReview(List<dynamic> reviewsJson) {
    productReviews = [];
    if (reviewsJson.length > 0) {
      for (var item in reviewsJson) {
        if (item != null) {
          productReviews.add(ProductReviews.fromJSon(item));
        }
      }
    }
  }

  void _setImages(List<dynamic> jsonImages) {
    productImages = [];
    if (jsonImages.length > 0) {
      for (var item in jsonImages) {
        if (item != null) {
          productImages.add(item['image_url']);
        }
      }
    }
  }

  String featuredImage() {
    if (this.productImages.length > 0) {
      return this.productImages[0];
    }
    return 'https://image.freepik.com/free-vector/online-shopping-concept-landing-page_52683-22153.jpg';
  }
}
