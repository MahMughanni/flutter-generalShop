class City {
  int city_id;

  String city_name;

  City(this.city_id, this.city_name);

  City.formJson(Map<String, dynamic> jsonObject) {
    this.city_id = jsonObject['city_id'];
    this.city_name = jsonObject['city_name'];
  }
}
