class ProductTags {
  int tag_id;
  String tag_name;

  ProductTags(this.tag_id, this.tag_name);

  ProductTags.fromJson(Map<String, dynamic> jsonObject) {
    this.tag_id = jsonObject['tag_id'];
    this.tag_name = jsonObject['tag_name'];
  }
}
