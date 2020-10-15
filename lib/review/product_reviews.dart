import 'package:flutter_generalshop/exceptions/exceptions.dart';
import 'package:flutter_generalshop/review/reviewer.dart';

class ProductReviews {
  int review_id, stars;
  String review;
  Reviewer reviewer;

  ProductReviews(this.review_id, this.stars, this.review, this.reviewer);

  ProductReviews.fromJSon(Map<String, dynamic> jsonObject) {
    assert(jsonObject['review_id'] != null, ' Review Id  IS null ');
    assert(jsonObject['stars'] != null, ' Stars  IS null ');
    assert(jsonObject['review'] != null, ' Review  IS null ');
    assert(jsonObject['reviewer'] != null, ' Reviewer IS null ');

    if (jsonObject['review_id'] == null) {
      throw PropertyIsRequired('Review ID');
    }
    if (jsonObject['stars'] == null) {
      throw PropertyIsRequired('Stars');
    }
    if (jsonObject['review'] == null) {
      throw PropertyIsRequired('Review');
    }
    if (jsonObject['reviewer'] == null) {
      throw PropertyIsRequired('Reviewer');
    }

    this.review_id = jsonObject['review_id'];
    this.stars = jsonObject['stars'];
    this.review = jsonObject['review'];
    this.reviewer = Reviewer.fromJson(jsonObject['reviewer']);
  }
}
