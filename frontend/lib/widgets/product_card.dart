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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
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
                        SizedBox(
                          width: 150,
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(22, 66, 118, .8),
                                fontSize: 16
                            ),
                          ),
                        ),
                        const Spacer(),
                        (product.discPrice != null)
                            ? Row(
                            children: [
                              Text(
                                product.price.toStringAsFixed(2),
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red,
                                    fontSize: 13
                                ),
                              ),
                              const SizedBox(width: 10,),
                            Text(
                              product.discPrice!.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(68, 153, 255, 1)
                              ),
                            )
                          ],

                        ): Text(
                          product.price.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(68, 153, 255, 1)
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      width: 150,
                      child: Text(
                        product.unitOfMeasure,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,

                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
