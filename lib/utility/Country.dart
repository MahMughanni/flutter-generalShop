import 'package:flutter_generalshop/exceptions/exceptions.dart';

class Country {
int country_id ;
String country_name , country_capital , country_currency  ;

Country(this.country_id, this.country_name, this.country_capital,
      this.country_currency);

Country.fromJson(Map<String , dynamic> jsonObject){
  assert(jsonObject['country_id'] != null , 'Country Id Is null ');
  assert(jsonObject['country_name'] != null , 'Country name Is null ');
  assert(jsonObject['country_capital'] != null , 'Country capital Is null ');
  assert(jsonObject['country_currency'] != null , 'Country Id currency null ');

  if(jsonObject['country_id'] == null){
    throw PropertyIsRequired('Country Id ');
  }
  if(jsonObject['country_name'] == null){
    throw PropertyIsRequired('Country name ');
  }
  if(jsonObject['country_capital'] == null){
    throw PropertyIsRequired('Country capital ');
  }
  if(jsonObject['country_currency'] == null){
    throw PropertyIsRequired('Country Currency ');
  }

  this.country_id = jsonObject['country_id'] ;
  this.country_name = jsonObject['country_name'] ;
  this.country_capital = jsonObject['country_capital'] ;
  this.country_currency = jsonObject['country_currency'] ;
}
}