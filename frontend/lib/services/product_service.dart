import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/product_model.dart';

class ProductService extends ChangeNotifier {
  static late List<Map<String, List<ProductModel>>> products;
  static late Map<String, double> pricePerStore;

  saveProducts(List<Map<String, List<ProductModel>>> prods) {
    // *saving the products
    products = prods;
    pricePerStore = {};
    // *iterating trough the array of stores and their products
    for (var stores in prods) {
      // *iterating trough the stores products
      stores.forEach((key, value) {
        if (pricePerStore[key] == null) {
          pricePerStore[key] = 0.0;
        }
        for (var product in value) {
          // * adding the discounted price if it has one
          log(product.toString());
          if (product.discPrice != null) {
            log("${pricePerStore[key]} = ${pricePerStore[key]!} + ${product.discPrice!}");
            pricePerStore[key] = pricePerStore[key]! + product.discPrice!;
          } else {
            pricePerStore[key] = pricePerStore[key]! + product.price;
          }
        }
        log("$key ${pricePerStore[key]}");
      });
    }
    notifyListeners();
  }
}