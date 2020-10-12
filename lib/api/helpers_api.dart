import 'package:flutter_generalshop/utility/City.dart';
import 'package:flutter_generalshop/utility/Country.dart';
import 'package:flutter_generalshop/product/product_category.dart';
import 'package:flutter_generalshop/product/product_tags.dart';
import 'package:flutter_generalshop/utility/country_state.dart';

class HelperAPi {
  Future<List<ProductCategory>> fetchCategories(int page) async {
    Map<String, String> headers = {'Accept': 'application/json'};
  }

  Future<List<ProductTags>> fetchTags(int page) async {}

  Future<List<Country>> fetchCountries(int page) {}

  Future<List<CountryState>> fetchStates(Country country) {}

  Future<List<City>> fetchCities(Country country) {}
}
