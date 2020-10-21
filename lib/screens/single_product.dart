import 'package:flutter/material.dart';
import 'package:flutter_generalshop/product/product.dart';

class SingleProduct extends StatefulWidget {
  final Product product;

  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product_title),
      ),
    );
  }
}
