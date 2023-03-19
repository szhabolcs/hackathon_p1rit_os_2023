import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/product_card.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    Key? key,
    required this.storeName,
    required this.products
  }) : super(key: key);

  final String storeName;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              storeName,
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
            Text(
              "${ProductService().getFinalPrice(storeName).toStringAsFixed(2)} RON",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromRGBO(68, 153, 255, 1)
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: (products.length - ProductService().getGroceryList().length == 0)
                        ? Colors.green
                        : (products.isEmpty)
                        ? Colors.red
                        : Colors.yellow,
                  ),
                  color: (products.length - ProductService().getGroceryList().length == 0)
                      ? Colors.green
                      : (products.isEmpty)
                      ? Colors.red
                      : Colors.yellow,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: Text(
                "${products.length}/${ProductService().getGroceryList().length}",
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
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          }
        )
      ],
    );
  }
}
