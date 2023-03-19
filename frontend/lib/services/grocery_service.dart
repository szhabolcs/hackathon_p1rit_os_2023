import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:frontend/utils/api_calls.dart';

import '../models/grocery_model.dart';

class GroceryService extends ChangeNotifier {
  static List<GroceryModel> groceries = [];

  saveGroceries(List<dynamic> gro) {
    groceries = [];
    for (var element in gro) {
      GroceryModel groceryModel = GroceryModel(
        element['id'],
        element['userId'],
        element['storeName'],
        double.parse(element['sum'].toString()),
        DateTime.parse(element['date']),
        element['query']
      );

      groceries.add(groceryModel);
      log(groceryModel.toString());
    }
    notifyListeners();
  }

  updateGroceries() async {
    final List<dynamic> resp = await ApiCalls().getGroceryLists();
    await saveGroceries(resp);
  }

  List<GroceryModel> getGroceryList() => groceries;
}