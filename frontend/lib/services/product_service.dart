import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/product_model.dart';

class ProductService extends ChangeNotifier {
  static late List<Map<String, List<ProductModel>>> products;
  static late Map<String, double> pricePerStore;
  static late List<String> groceryList;

  saveProducts(List<Map<String, List<ProductModel>>> prods, List<String> list) {
    // *saving the products
    products = prods;
    groceryList = list;
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
          if (product.discPrice != null) {
            pricePerStore[key] = pricePerStore[key]! + product.discPrice!;
          } else {
            pricePerStore[key] = pricePerStore[key]! + product.price;
          }
        }
      });
    }
    notifyListeners();
    return true;
  }

  getStoresCount() => pricePerStore.length;

  getStores() => products;

  getStoreNameAtIndex(int index) => pricePerStore.keys.elementAt(index);
  getProductsByKey(String key) {
    for (var element in products) {
      if (element.keys.elementAt(0) == key) {
        return element[key];
      }
    }
  }

  List<String> getGroceryList() => groceryList;

  double getFinalPrice(String key) => pricePerStore[key] ?? 0;

  updatePrice(String key, ProductModel newProduct, int oldProductID) {
    log(key);
    for (var element in products) {
      if (element.keys.first == key) {
        // log(element.toString());
        if (element[key] == null) continue;
        for (var element in element[key]!) {
          if (element.id == oldProductID) {
            // log("${pricePerStore[key]} = ${pricePerStore[key]!} + ${newProduct.price}");
            if (newProduct.discPrice != null) {
              pricePerStore[key] = pricePerStore[key]! + newProduct.discPrice!;
              pricePerStore[key] = pricePerStore[key]! - element.discPrice!;
            } else {
              pricePerStore[key] = pricePerStore[key]! + newProduct.price;
              pricePerStore[key] = pricePerStore[key]! - element.price;
            }

            // log("${pricePerStore[key]} = ${pricePerStore[key]!} - ${element.price}");
            pricePerStore[key] = pricePerStore[key]! - element.price;
          }
        }
      }
    }
    notifyListeners();
  }
}