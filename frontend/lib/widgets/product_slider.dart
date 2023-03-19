import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({
        Key? key,
        required this.product
      }) : super(key: key);

  final ProductModel product;

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {

  late ProductService productService = ProductService();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async{
      productService = Provider.of<ProductService>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: CarouselSlider.builder(
          itemCount: (widget.product.others.length == 1)
              ? 2
              : widget.product.others.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            // log(product.others.length.toString());
            // Future.delayed(Duration.zero, () =>
            //     productService.updatePrice(widget.product.storeName, (itemIndex == 0) ? widget.product :widget.product.others[itemIndex - 1], widget.product.id));
            return (itemIndex == 0)
                ? ProductCard(product: widget.product)
                : ProductCard(product: widget.product.others[itemIndex - 1]);
          },
          options: CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll: false,
            viewportFraction: 0.93,
            enlargeFactor: 0.5,
            onPageChanged: (index, asd) {
              productService.updatePrice(widget.product.storeName, (index == 0) ? widget.product :widget.product.others[index - 1], widget.product.id);
            },
          )
      ),
    );
  }
}
