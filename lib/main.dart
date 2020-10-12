import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/api_product.dart';
import 'package:flutter_generalshop/api/authentication.dart';
import 'package:flutter_generalshop/api/helpers_api.dart';
import 'package:flutter_generalshop/exceptions/login_failed.dart';
import 'package:flutter_generalshop/exceptions/resource_not_found.dart';
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
  HelperAPi helperAPi = HelperAPi();
  Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Shop'),
      ),
      body: FutureBuilder(
        future: authentication.login('asdas@asdas.com', 'asdasdas'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                switch (snapshot.error) {
                  case LoginFailed:
                    return _error('Username is not correct');
                    break;
                  case ResourceNotFound:
                    return _error('not found resources');
                    break;

                }
                return _error(snapshot.error.toString());
              } else {
                if (!snapshot.hasData) {
                  return _error('no Data');
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int position) {
                      return _drawCard(snapshot.data[position]);
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

_drawCard(dynamic item) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(item.state_name),
    ),
  );
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
