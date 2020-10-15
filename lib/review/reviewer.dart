import 'package:flutter_generalshop/exceptions/exceptions.dart';

class Reviewer {
  String first_name, last_name, email, formattedName;

  Reviewer(this.first_name, this.last_name, this.email, this.formattedName);


  Reviewer.fromJson(Map<String, dynamic> jsonObject) {
    assert ( jsonObject['first_name'] != null , ' First name Is null ');
    assert ( jsonObject['last_name'] != null , ' Last name Is null ');
    assert ( jsonObject['email'] != null , ' Email Is null ');
    assert ( jsonObject['formattedName'] != null , ' Formatted Name Is null ');

    if(jsonObject['first_name'] == null){
      throw PropertyIsRequired('First Name');
    }
    if(jsonObject['last_name'] == null){
      throw PropertyIsRequired('Last Name');
    }
    if(jsonObject['email'] == null){
      throw PropertyIsRequired('Email');
    }
    if(jsonObject['formattedName'] == null){
      throw PropertyIsRequired(' Formatted Name');
    }



    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.formattedName = jsonObject['formattedName'];
  }
}
