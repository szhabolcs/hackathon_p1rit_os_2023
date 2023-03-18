import 'package:flutter/material.dart';
import 'package:frontend/view/list/list_page.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../services/user_service.dart';
// import 'package:frontend/services/user_service.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index ) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        color: Colors.red,
                        height: 100,
                        width: double.infinity,

                      ),
                    );
                  }
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
