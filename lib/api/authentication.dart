import 'dart:convert';

import 'package:flutter_generalshop/customer/user.dart';
import 'package:flutter_generalshop/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import 'api_utl.dart';

class Authentication {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<User> register(String first_name, String last_name, String email,
      String password) async {

    await checkInternet();

    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
    };

    http.Response response =
        await http.post(APiUtl.AUTH_REGISTER, headers: headers, body: body);
    switch (response.statusCode) {
      case 201:
        var body = jsonDecode(response.body);
        var data = body['data'];
        return User.fromJson(data);
        break;
      case 404:
        throw ResourceNotFound('');
        break;
      case 500:
        throw Exceptions();
        break;
      case 422:
        throw UnProcessEntity();
        break;
      default:
        return null;
        break;
    }
  }

  Future<User> login(String email, String password) async {
    await checkInternet();

    Map<String, String> body = {'email': email, 'password': password};
    http.Response response =
        await http.post(APiUtl.AUTH_LOGIN, headers: headers, body: body);
    print(response.statusCode);

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];
        return User.fromJson(data);
        break;
      case 404:
        throw ResourceNotFound('User');
        break;
      case 401:
        throw LoginFailed();
        break;
      default:
        return null;
        break;
    }
  }
}
