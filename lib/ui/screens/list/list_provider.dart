import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yuka_clone/data/model/product.dart';

class ProductsListProviders {
  final MethodChannel _channel =
      const MethodChannel('com.meetup.kotlin.paris.openfoodfacts/application');
  final StreamController<ProductsListEvent> _controller = StreamController();

  void fetchProducts() async {
    _controller.add(ProductsListEvent.loading());

    var list = await _channel.invokeMethod('getProductList');
    List jsonList = json.decode(list);

    _controller.add(ProductsListEvent.loaded(
        jsonList.map((item) => Product.fromAPI(item)).toList(growable: false)));
  }

  Future<Product> findProduct(String barcode) async {
    try {
      var api = await _channel.invokeMethod('getProduct', {'barcode': barcode});

      return Product.fromAPI(json.decode(api));
    } catch (err, trace) {
      print(err);
      print(trace);
      return null;
    }
  }

  Stream<ProductsListEvent> get productsListStream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}

class ProductsListEvent {
  final ProductsListState state;
  final List<Product> products;

  ProductsListEvent.loading()
      : state = ProductsListState.loading,
        products = null;

  ProductsListEvent.error()
      : state = ProductsListState.error,
        products = null;

  ProductsListEvent.loaded(this.products) : state = ProductsListState.loaded;
}

enum ProductsListState { loading, loaded, error }
