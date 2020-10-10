import 'package:flutter_generalshop/review/reviewer.dart';

class ProductReviews {
  int review_id, stars;
  String review;
  Reviewer reviewer;

  ProductReviews(this.review_id, this.stars, this.review, this.reviewer);

  ProductReviews.fromJSon(Map<String, dynamic> jsonObject) {
    this.review_id = jsonObject['review_id'];
    this.stars = jsonObject['stars'];
    this.review = jsonObject['review'];
    this.reviewer = Reviewer.fromJson(jsonObject['reviewer']);
  }
}
