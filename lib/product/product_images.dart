class ProductImages {
  int image_id;
  String image_url;


  ProductImages(this.image_id, this.image_url);

  ProductImages.fromJson(Map<String, dynamic> jsonObject) {
    this.image_id = jsonObject['image_id'];
    this.image_url = jsonObject['image_url'];
  }

}
