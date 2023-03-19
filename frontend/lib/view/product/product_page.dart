import 'package:flutter/material.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/widgets/store_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                const Text(
                  "Our offers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(22, 66, 118, 1)
                  ),
                ),
                const SizedBox(height: 30,),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: ProductService().getStoresCount(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return StoreCard(
                      storeName: ProductService().getStoreNameAtIndex(index),
                      products: ProductService().getProductsByKey(ProductService().getStoreNameAtIndex(index)),
                    );
                  }
                )
            ],
            ),
          ),
        )
      ),
    );
  }
}
