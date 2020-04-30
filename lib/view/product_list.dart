import 'package:flutter/material.dart';
import 'package:flutter_streams_products/blocs/poducts_bloc.dart';
import 'package:flutter_streams_products/model/product.dart';

class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  ProductsBloc productsBloc = ProductsBloc();

  @override
  void dispose() {
    productsBloc.dispose();
    super.dispose();
  }

  TextStyle _mStyle = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productsBloc.productStream,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error!');
            } else {
              List<Product> products = snapshot.data;
              return Column(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, position) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(products[position].title, style: _mStyle),
                              Text(products[position].id, style: _mStyle),
                              RaisedButton(
                                  child: Text('remove'),
                                  onPressed: () {
                                    productsBloc.removeProduct
                                        .add(products[position]);
                                  }),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  RaisedButton(
                      color: Colors.white,
                      child: Text('add'),
                      onPressed: () {
                        Product product = Product("9", "product 9", 50000);
                        productsBloc.addProduct.add(product);
                      }),
                  SizedBox(
                    height: 16,
                  )
                ],
              );
            }
            break;
        }
      },
    );
  }
}
