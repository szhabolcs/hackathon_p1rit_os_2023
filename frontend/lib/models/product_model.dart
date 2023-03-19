import 'package:frontend/widgets/product_card.dart';

class ProductModel {
  late int id;
  late String name;
  late double  price;
  late double? discPrice;
  late String unitOfMeasure;
  late String image;
  late String storeName;
  late List<ProductModel> others;

  ProductModel(this.id, this.name, this.price, this.discPrice, this.unitOfMeasure, this.image, this.storeName, this.others);

  @override
  String toString() {
    return "{\n"
        "id: $id,\n"
        "name: $name,\n"
        "price: $price,\n"
        "discPrice: $discPrice,\n"
        "utilOfMeasure: $unitOfMeasure,\n"
        "image: $image,\n"
        "storeName: $storeName\n"
        "others: ${others.toString()}"
        "\n}";
  }
}