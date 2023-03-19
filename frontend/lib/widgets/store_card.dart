import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/models/grocery_model.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/grocery_service.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/widgets/product_card.dart';
import 'package:frontend/widgets/product_slider.dart';
import 'package:provider/provider.dart';

import '../utils/api_calls.dart';

class StoreCard extends StatefulWidget {
  const StoreCard({
    Key? key,
    required this.storeName,
    required this.products
  }) : super(key: key);

  final String storeName;
  final List<ProductModel> products;

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {

  late ProductService productService = ProductService();
  late GroceryService groceryService = GroceryService();

  @override
  void initState() {
    productService = Provider.of<ProductService>(context, listen: false);
    groceryService = Provider.of<GroceryService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.storeName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(22, 66, 118, 1)
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0.5),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(22, 66, 118, .5),
                  ),
                  color: const Color.fromRGBO(22, 66, 118, 1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:const [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "1.3km",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Consumer<ProductService> (
              builder: (context, data, child) {
                return Text(
                  "${ProductService().getFinalPrice(widget.storeName).toStringAsFixed(2)} RON",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromRGBO(68, 153, 255, 1)
                  ),
                );
              }
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: (widget.products.length - ProductService().getGroceryList().length == 0)
                        ? Colors.green
                        : (widget.products.isEmpty)
                        ? Colors.red
                        : Colors.orange,
                  ),
                  color: (widget.products.length - ProductService().getGroceryList().length == 0)
                      ? Colors.green
                      : (widget.products.isEmpty)
                      ? Colors.red
                      : Colors.orange,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: Text(
                "${widget.products.length}/${ProductService().getGroceryList().length}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 30,),
        ListView.builder (
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return (widget.products[index].others.isNotEmpty)
                ? ProductSlider(product: widget.products[index])
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: ProductCard(product: widget.products[index]),
                  );
          }
        ),
        const SizedBox(height: 30,),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color.fromRGBO(68, 153, 255, 1)
            ),

            onPressed: () async {
              if (await ApiCalls().saveGroceryLists(widget.products) == "OK") {
                groceryService.updateGroceries();
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(
                  fontSize: 16
              ),
            )
        ),
        const SizedBox(height: 30,),

      ],
    );
  }
}
