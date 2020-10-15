import 'package:flutter_generalshop/exceptions/exceptions.dart';

class ProductTags {
  int tag_id;
  String tag_name;

  ProductTags(this.tag_id, this.tag_name);

  ProductTags.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['tag_id'] != null, ' Tag ID is Null ');
    assert(jsonObject['tag_name'] != null, ' Tag name is Null ');

    if (jsonObject['tag_id'] == null) {
      throw PropertyIsRequired('Tag ID');
    }
    if (jsonObject['tag_name'] == null) {
      throw PropertyIsRequired('Tag Name ');
    }
    this.tag_id = jsonObject['tag_id'];
    this.tag_name = jsonObject['tag_name'];
  }
}
