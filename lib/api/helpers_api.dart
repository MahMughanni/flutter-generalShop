import 'dart:convert';

import 'package:flutter_generalshop/api/api_utl.dart';
import 'package:flutter_generalshop/utility/City.dart';
import 'package:flutter_generalshop/utility/Country.dart';
import 'package:flutter_generalshop/product/product_category.dart';
import 'package:flutter_generalshop/product/product_tags.dart';
import 'package:flutter_generalshop/utility/country_state.dart';
import 'package:http/http.dart' as http;

class HelperAPi {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<ProductCategory>> fetchCategories(int page) async {
    String url = APiUtl.CATEGORIES + '?page=' + page.toString();

    http.Response response = await http.get(url, headers: headers);
    List<ProductCategory> categoriesList = [];

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        categoriesList.add(ProductCategory.fromJson(item));
      }
    }

    return categoriesList;
  }

  Future<List<ProductTags>> fetchTags(int page) async {
    String url = APiUtl.TAGS + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<ProductTags> tagsList = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        tagsList.add(ProductTags.fromJson(item));
      }
    }

    return tagsList;
  }

  Future<List<Country>> fetchCountries(int page) async {
    String url = APiUtl.COUNTRIES + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<Country> countriesList = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        countriesList.add(Country.fromJson(item));
      }
    }

    return countriesList;
  }

  Future<List<CountryState>> fetchStates(Country country, int page) async {
    String url = APiUtl.STATES(country.country_id) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<CountryState> statesList = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        statesList.add(CountryState.fromJspn(item));
      }
    }
    return statesList;
  }

  Future<List<City>> fetchCities(Country country, int page) async {
    String url = APiUtl.CITIES(country.country_id) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<City> citiesList = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        citiesList.add(City.formJson(item));
      }
    }
    return citiesList;
  }
}
