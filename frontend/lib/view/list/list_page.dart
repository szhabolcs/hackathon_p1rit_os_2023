import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Input the list",),
              scrollPadding: EdgeInsets.all(20.0),
              autofocus: true,
            )
        ),
      ),
    );
  }
}
