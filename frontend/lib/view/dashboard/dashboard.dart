import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/models/grocery_model.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/grocery_service.dart';
import 'package:frontend/utils/api_calls.dart';
import 'package:frontend/view/list/list_page.dart';
import 'package:frontend/widgets/grocery_card.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../services/user_service.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {


  late GroceryService groceryService = GroceryService();


  @override
  void initState() {
    groceryService = Provider.of<GroceryService>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      List<dynamic> groceryList = await ApiCalls().getGroceryLists();
      groceryService.saveGroceries(groceryList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            const SizedBox(height: 80,),
            Text(
              "Hi, ${UserService().getUser().name}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(22, 66, 118, 1)
              ),
            ),
            // Text("Hi, ${UserService().getUser().name}")
            const SizedBox(height: 80,),
            StickyHeader(
              header: Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: const Color.fromRGBO(68, 153, 255, 1)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ListPage()));
                  },
                  child: const Text("New"),
                ),
              ),
              // content: Container(),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Consumer<GroceryService>(
                  builder: (context, data, child) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: GroceryService().getGroceryList().length,
                        itemBuilder: (context, index ) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GroceryCard(grocery: groceryService.getGroceryList()[index],),
                          );
                        }
                    );
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
