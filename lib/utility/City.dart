import 'package:flutter_generalshop/exceptions/exceptions.dart';

class City {
  int city_id;

  String city_name;

  City(this.city_id, this.city_name);

  City.formJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['city_id'] != null, 'City ID is null');
    assert(jsonObject['city_name'] != null, 'City name is null');

    if (jsonObject['city_id'] == null) {
      throw PropertyIsRequired(' City ID');
    }
    if (jsonObject['city_name'] == null) {
      throw PropertyIsRequired('City Name ');
    }

    this.city_id = jsonObject['city_id'];
    this.city_name = jsonObject['city_name'];
  }
}
