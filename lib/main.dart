import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/api_product.dart';
import 'package:flutter_generalshop/api/authentication.dart';
import 'package:flutter_generalshop/product/product.dart';
import 'package:flutter_generalshop/product/product_category.dart';

void main() {
  runApp(GeneralShop());
}

class GeneralShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductAPI productAPI = ProductAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Shop'),
      ),
      body: FutureBuilder(
        future: productAPI.fetchProducts(1),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              _error('nothing happened');

              break;
            case ConnectionState.waiting:
              _loading();
              break;
            case ConnectionState.active:
              _loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return _error(snapshot.error.toString());
              } else {
                if (!snapshot.hasData) {
                  return _error('no Data');
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int position) {
                      return _drawProducts(snapshot.data[position]);
                    },
                    itemCount: snapshot.data.length,
                  );
                }
              }

              break;
          }
          return Container();
        },
      ),
    );
  }
}

_loading() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

_error(String error) {
  return Container(
    child: Center(
      child: Text(error),
    ),
  );
}

_drawProducts(Product product) {
  return Card(
    child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(product.product_title),
            (product.productImages.length > 0)
                ? Image(
                    image: NetworkImage(product.productImages[0]),
                  )
                : Container(),
          ],
        )),
  );
}
