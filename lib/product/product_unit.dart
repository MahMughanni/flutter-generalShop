import 'package:flutter_generalshop/exceptions/exceptions.dart';

class ProductUnit {
  int unit_id;

  String unit_name, unit_code;

  ProductUnit(this.unit_id, this.unit_name, this.unit_code);

  ProductUnit.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['unit_id'] != null, 'Unit ID is Null');
    assert(jsonObject['unit_name'] != null, 'Unit name is Null');
    assert(jsonObject['unit_code'] != null, 'Unit code is Null');

    if (jsonObject['unit_id'] == null) {
      throw PropertyIsRequired('Unit ID');
    }
    if (jsonObject['unit_name'] == null) {
      throw PropertyIsRequired('Unit Name ');
    }
    if (jsonObject['unit_code'] == null) {
      throw PropertyIsRequired('Unit Code');
    }

    this.unit_id = jsonObject['unit_id'];
    this.unit_name = jsonObject['unit_name'];
    this.unit_code = jsonObject['unit_code'];
  }
}
