import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/utils/api_calls.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  final _formKey = GlobalKey<FormState>();

  late List<String> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: const Size.fromHeight(50),
              backgroundColor: const Color.fromRGBO(68, 153, 255, 1)
          ),
          child: const Text("Search"),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final resp = await ApiCalls().search(list);

              final Map<String, dynamic> data = json.decode(resp);
              log(data.toString());
              final List<Map<String, List<ProductModel>>> products = [];

              data.forEach((key, value) {
                products.add({key: []});
                for (var element in (value as List)) {
                  final ProductModel productModel = ProductModel(
                      element['id'],
                      element['name'],
                      element['price'],
                      element['discountedPrice'],
                      element['unitOfMeasure'],
                      element['image'],
                      element['storeName']);
                  products.last[key]!.add(productModel);
                }
              });


              ProductService().saveProducts(products);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Text(
              "List",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(22, 66, 118, 1)
              ),
            ),
            const SizedBox(height: 50,),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "Please enter something!";
                      },
                      onSaved: (String? value) {
                        late LineSplitter ls = const LineSplitter();
                        list = ls.convert(value ?? "");
                      },
                      decoration: const InputDecoration.collapsed(
                        hintText: "Input the list",
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      scrollPadding: const EdgeInsets.all(20.0),
                      autofocus: true,
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
