class Country {
int country_id ;
String country_name , country_capital , country_currency  ;

Country(this.country_id, this.country_name, this.country_capital,
      this.country_currency);

Country.fromJson(Map<String , dynamic> jsonObject){
  this.country_id = jsonObject['country_id'] ;
  this.country_name = jsonObject['country_name'] ;
  this.country_capital = jsonObject['country_capital'] ;
  this.country_currency = jsonObject['country_currency'] ;
}
}