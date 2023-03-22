import 'package:flutter/material.dart';
import 'package:frontend/models/grocery_model.dart';
import 'package:frontend/widgets/grocery_bottom_modal.dart';

class GroceryCard extends StatelessWidget {
  const GroceryCard({
    Key? key,
    required this.grocery
  }) : super(key: key);

  final GroceryModel grocery;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          elevation: .2,
          context: context,
          builder: (context) {
            return Container(
              child: GroceryBottomModal(
                groceryId: grocery.id,
                total: grocery.sum,
              ),
            );
          }
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: Text(
                  grocery.query,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Text(
                grocery.sum.toStringAsFixed(2)
              )
            ],

          ),
          Row(
            children: [
              Text(grocery.storeName),
              const SizedBox(width: 20,),
              Text(grocery.date.toString())
            ],
          )
        ],
      ),
    );
  }
}
