import 'dart:async';

import 'package:flutter_streams_products/contracts/disposable.dart';
import 'package:flutter_streams_products/model/product.dart';

class ProductsBloc implements Disposable {
  List<Product> products;

  final StreamController<List<Product>> _productListStreamController =
      StreamController<List<Product>>();

  Stream<List<Product>> get productStream =>
      _productListStreamController.stream;

  StreamSink<List<Product>> get productStreamSink =>
      _productListStreamController.sink;

  final StreamController<Product> _addProductStreamController =
      StreamController<Product>();

  StreamSink<Product> get addProduct => _addProductStreamController.sink;

  final StreamController<Product> _removeProductStreamController =
      StreamController<Product>();

  StreamSink<Product> get removeProduct => _removeProductStreamController.sink;

  ProductsBloc() {
    products = [];
    _productListStreamController.add(products);
    _addProductStreamController.stream.listen(_addProduct);
    _removeProductStreamController.stream.listen(_removeProduct);
  }

  void _addProduct(Product product) {
    products.add(product);
    productStreamSink.add(products);
  }

  void _removeProduct(Product product) {
    products.remove(product);
    productStreamSink.add(products);
  }

  @override
  void dispose() {
    _productListStreamController.close();
    _addProductStreamController.close();
    _removeProductStreamController.close();
  }
}
