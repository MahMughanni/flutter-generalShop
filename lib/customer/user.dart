import 'package:flutter_generalshop/exceptions/exceptions.dart';

class User {
  String first_name;
  String last_name;
  String email;
  String api_token; // optional on constructor
  int user_id; // optional on constructor

  User(this.first_name, this.last_name, this.email,
      [this.api_token, this.user_id]);

  User.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['user_id'] != null, 'User ID is null ');
    assert(jsonObject['first_name'] != null, 'first Name is null ');
    assert(jsonObject['last_name'] != null, 'last Name is null ');
    assert(jsonObject['email'] != null, 'email is null ');
    assert(jsonObject['api_token'] != null, 'Api Token is null ');

    if (jsonObject['user_id'] == null) {
      throw PropertyIsRequired('USer ID');
    }
    if (jsonObject['first_name'] == null) {
      throw PropertyIsRequired('First Name ');
    }
    if (jsonObject['last_name'] == null) {
      throw PropertyIsRequired('Last Name');
    }
    if (jsonObject['email'] == null) {
      throw PropertyIsRequired('Email');
    }
    if (jsonObject['api_token'] == null) {
      throw PropertyIsRequired('Api Token');
    }
    this.user_id = jsonObject['user_id'];
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.api_token = jsonObject['api_token'];
  }
}
