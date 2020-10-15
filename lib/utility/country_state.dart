import 'package:flutter_generalshop/exceptions/exceptions.dart';

class CountryState {
  int state_id;

  String state_name;

  CountryState(this.state_id, this.state_name);

  CountryState.fromJspn(Map<String, dynamic> jsonObject) {
    assert(jsonObject['state_id'] != null, "State Id is Null ");
    assert(jsonObject['state_name'] != null, "State name  is Null ");
    if (jsonObject['state_id'] == null) {
      throw PropertyIsRequired('State ID');
    }
    if (jsonObject['state_name'] == null) {
      throw PropertyIsRequired('State Name');

    }
    this.state_id = jsonObject['state_id'];
    this.state_name = jsonObject['state_name'];
  }
}
