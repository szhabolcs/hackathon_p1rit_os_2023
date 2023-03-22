import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/utils/api_calls.dart';
import 'package:frontend/widgets/product_card.dart';

class GroceryBottomModal extends StatelessWidget {
  const GroceryBottomModal({
    Key? key,
    required this.groceryId,
    required this.total
  }) : super(key: key);

  final int groceryId;
  final double total;

  @override
  Widget build(BuildContext context) {

    late List<ProductModel> products = [];

    return FutureBuilder(
      future: ApiCalls().getSavedGroceryListById(groceryId),
      builder: (context, data) {
        if (data.hasData) {
          if (data.data == null) {
            return Center(
              child: Text("Error!!"),
            );
          }
          products = [];
          for (var element in  json.decode(data.data! as String)) {
            final ProductModel productModel = new ProductModel(
            element['id'],
            element['name'],
            element['price'],
            element['discountedPrice'],
            element['unitOfMeasure'],
            element['image'],
            element['storeName'],
            []);

            products.add(productModel);
          }
          return ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 50,),
              Center(
                child: Text(
                  products[0].storeName,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(22, 66, 118, 1)
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  log(products.length.toString());
                  return Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: ProductCard(product: products[index]),
                  );
                }),
              const SizedBox(height: 30,),
              Center(
                child: Text('Total: ${total}'),
              ),
              const SizedBox(height: 30,),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
