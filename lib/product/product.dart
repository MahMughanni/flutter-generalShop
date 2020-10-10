import 'package:flutter_generalshop/product/product_images.dart';
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
    this.product_id = jsonObject['product_id'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_total = double.tryParse(jsonObject['product_total']);
    this.product_price = double.tryParse(jsonObject['product_price']);
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    this.product_unit = ProductUnit.fromJson(jsonObject['product_unit']);
    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);
    productImages = [];
    if (jsonObject['product_images'] != null) {
      _setImages(jsonObject['product_images']);
    }

    this.productReviews = [];
    if (jsonObject['product_reviews'] != null) {
      _setReview(jsonObject['product_reviews']);
    }

    _setTags(jsonObject['product_tags']);
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
}
