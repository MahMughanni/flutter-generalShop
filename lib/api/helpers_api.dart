import 'dart:convert';
import 'package:flutter_generalshop/api/api_utl.dart';
import 'package:flutter_generalshop/exceptions/redirectionsFound.dart';
import 'package:flutter_generalshop/exceptions/resource_not_found.dart';
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

    switch (response.statusCode) {
      case 200:
        List<ProductCategory> categoriesList = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          categoriesList.add(ProductCategory.fromJson(item));
        }

        return categoriesList;
        break;
      case 404:
        throw ResourceNotFound('Categories');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break ;
    }
  }

  Future<List<ProductTags>> fetchTags(int page) async {
    String url = APiUtl.TAGS + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List<ProductTags> tagsList = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          tagsList.add(ProductTags.fromJson(item));
        }
        return tagsList;
        break;
      case 404:
        throw ResourceNotFound('Tags');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break ;

    }
  }

  Future<List<Country>> fetchCountries(int page) async {
    String url = APiUtl.COUNTRIES + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List<Country> countriesList = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          countriesList.add(Country.fromJson(item));
        }
        return countriesList;
        break;
      case 404:
        throw ResourceNotFound('Countries');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break ;

    }
  }

  Future<List<CountryState>> fetchStates(int country_id, int page) async {
    String url = APiUtl.STATES(country_id) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List<CountryState> statesList = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          statesList.add(CountryState.fromJspn(item));
        }
        return statesList;
        break;
      case 404:
        throw ResourceNotFound('States');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break ;

    }
  }

  Future<List<City>> fetchCities(int country_id, int page) async {
    String url = APiUtl.CITIES(country_id) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List<City> citiesList = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          citiesList.add(City.formJson(item));
        }
        return citiesList;
        break;
      case 404:
        throw ResourceNotFound('Cities');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break ;

    }
  }
}
