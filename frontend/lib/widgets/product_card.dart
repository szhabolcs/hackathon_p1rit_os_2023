import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product
  }) : super(key: key);

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          product.image,
          height: 80,
          width: 80,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(22, 66, 118, .8),
                      fontSize: 16
                    ),
                  ),
                  const Spacer(),
                  (product.discPrice != null)
                      ? Row(
                      children: [
                        Text(
                          product.price.toStringAsFixed(3),
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red,
                            fontSize: 13
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          product.discPrice!.toStringAsFixed(3),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(68, 153, 255, 1)
                          ),
                        )
                      ],

                  ): Text(
                        product.price.toStringAsFixed(3),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(68, 153, 255, 1)
                        ),
                      ),
                ],
              ),
              const SizedBox(height: 5,),
              Text(
                product.unitOfMeasure,
                style: const TextStyle(
                  fontSize: 13,

                ),
                textAlign: TextAlign.start,
              )
            ],
          ),
        )
      ],
    );
  }
}
